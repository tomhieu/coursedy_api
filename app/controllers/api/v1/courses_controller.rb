module Api
  module V1
    class CoursesController < ApiController
      skip_before_action :authenticate_user!, only: [:index, :search, :view]

      wrap_parameters include: [:title, :description, :start_date, :is_free,
                                :number_of_students, :period, :tuition_fee, :category_id, :is_public,
                                :course_level_id, :currency, :week_day_schedules_attributes, :cover_image
      ]

      skip_before_action :authenticate_user!, only: [:follow, :show, :index, :show]

      def index
        @courses = Course.includes(:tutor, :category, :course_level, :week_day_schedules)
        if params[:sort_by] == 'popularity'
          @courses = @courses.order(views: :desc)
        elsif params[:sort_by] == 'time_desc'
          @courses = @courses.order(created_at: :desc)
        elsif params[:sort_by] == 'time_asc'
          @courses = @courses.order(created_at: :asc)
        else
          @courses = @courses.all
        end
        render json: @courses.includes(:tutor, :category, :course_level, :week_day_schedules), each_serializer: CoursesSerializer, full_info: true
      end

      def search
        categories = (params[:categories] || []) + (params[:specializes] || [])

        solr_search = Course.search do
          fulltext params[:q]

          if !categories.blank?
            with(:category_id, params[:categories])
          end

          if !params[:locations].blank?
            with(:city_id, params[:locations])
          end

          if !params[:min_fee].blank?
            with(:tuition_fee).greater_than(params[:min_fee].to_i)
          end

          if !params[:max_fee].blank?
            with(:tuition_fee).less_than(params[:max_fee].to_i)
          end

          with :is_public, :true
          # order_by :published_at, :desc
          paginate :page => params[:page] || 1, :per_page => params[:per_page] || 10
        end

        render json: solr_search.results, each_serializer: CoursesSerializer
      end

      def view
        @course = Course.find(params[:id])
        CourseView.new(@course).update_course_view(params[:token])
        render json: @course, serializer: CoursesSerializer
      end

      def create
        @course = Course.new(course_params)
        @course.user_id = current_user.id

        if @course.save
          render json: @course, serializer: CoursesSerializer
        else
          render_error_response(@course.errors, :unprocessable_entity)
        end
      end

      def show
        @course = Course.find(params[:id])
        # for course views count
        token = CourseView.new(@course).new_view
        render json: @course, serializer: CoursesSerializer, view_token: token, full_info: true
      end

      def update
        @course = Course.find(params[:id])

        if @course.update_attributes(course_params)
          render json: @course, serializer: CoursesSerializer
        else
          render_error_response(@course.errors.full_messages.first, :unprocessable_entity)
        end
      end

      def destroy
        @course = Course.find(params[:id])
        @course.destroy
        render json: {id: @course.id}
      end

      def follow
        subscription = CourseSubscriber.create(user_id: current_user.id, course_id: params[:id])

        render json: subscription, each_serializer: CourseSubscriberSerializer
      end

      def enroll
        @course = Course.find(params[:id])
        @participation = Participation.create(user_id: current_user.id, course_id: @course.id)
        render json: @participation, serializer: ParticipationsSerializer
      end

      def user_enrolled
        @course = Course.find(params[:id])
        enrolled = Participation.where(user_id: current_user.id, course_id: @course.id).exists?
        render_success_response(enrolled: enrolled)
      end

      private

      def course_params
        params.require(:course).permit(:title, :description, :start_date, :is_free,
                                       :number_of_students, :period, :tuition_fee, :category_id, :is_public,
                                       :course_level_id, :currency, :cover_image, week_day_schedules_attributes: [:day, :start_time, :end_time]
        )
      end
    end
  end
end
