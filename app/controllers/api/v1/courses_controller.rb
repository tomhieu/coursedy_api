module Api
  module V1
    class CoursesController < ApiController
      skip_before_action :authenticate_user!, only: [:index, :search, :view, :get_rating]

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
        @courses = paginate @courses.includes(:tutor, :category, :course_level, :week_day_schedules)
        render json: @courses, each_serializer: CoursesSerializer, full_info: true
      end

      def related_courses
        @course = Course.find(params[:course_id])
        @courses = Course.includes(:tutor, :category, :course_level, :week_day_schedules)
                     .where(category_id: @course.category_id).order(created_at: :desc)
        @courses = paginate @courses

        render json: @courses, each_serializer: CoursesSerializer, full_info: true
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
        end

        @courses = paginate Course.where(id: solr_search.results.map(&:id)).includes(:tutor, :category, :course_level, :week_day_schedules)

        render json: @courses, each_serializer: CoursesSerializer, full_info: true
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

        if course_params[:week_day_schedules_attributes]
          schedule_to_delete = @course.week_day_schedules.pluck(:id)
        end

        if @course.update_attributes(course_params)
          WeekDaySchedule.where(id: schedule_to_delete).destroy_all
          render json: @course.reload, serializer: CoursesSerializer, full_info: true
        else
          @course.reload.week_day_schedules.where.not(id: schedule_to_delete).destroy_all
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

      def get_rating
        course = Course.find(params[:id])
        if course.course_ratings.count == 0
          render json: {rating: 0} and return
        end

        course.course_ratings.sum(:points).to_f/course.course_ratings.count
        render json: {rating: 1}
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
