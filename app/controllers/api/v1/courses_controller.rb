module Api
  module V1
    class CoursesController < ApiController
      wrap_parameters include: [:title, :description, :start_date, :is_free,
        :number_of_students, :period, :tuition_fee, :category_id, :is_public,
        :course_level_id, :currency, :week_day_schedules_attributes, :cover_image
      ]

      skip_before_action :authenticate_user!, only: [:follow, :show, :index]

      def index
        @courses  = Course.includes(:tutor, :category, :course_level, :week_day_schedules)
        if params[:sort_by] == 'popularity'
          @courses = @courses.order(views: :desc)
        elsif params[:sort_by] == 'time_desc'
          @courses = @courses.order(created_at: :desc)
        elsif params[:sort_by] == 'time_asc'
          @courses = @courses.order(created_at: :asc)
        else
          @courses = @courses.all
        end
        render json: Course.includes(:tutor, :category, :course_level, :week_day_schedules).all, each_serializer: CoursesSerializer
      end

      def search
        binding.pry
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
        render json: @course, serializer: CoursesSerializer, view_token: token
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
