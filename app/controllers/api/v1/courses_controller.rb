module Api
  module V1
    class CoursesController < ApiController
      wrap_parameters include: [:title, :description, :start_date, :is_free,
        :number_of_students, :period, :tuition_fee, :category_id, :is_public,
        :course_level_id, :currency, :week_day_schedules_attributes, :cover_image
      ]

      skip_before_action :authenticate_user!, only: [:follow]

      def index
        render json: Course.includes(:tutor, :category, :course_level, :week_day_schedules).all, each_serializer: CoursesSerializer
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
        if current_user && current_user.id == @course.user_id || @course.is_public
          render json: @course, serializer: CoursesSerializer
        else
          render_error_response('course not found')
        end
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
        @course = Course.find(params[:id])
        email = ActionView::Base.full_sanitizer.sanitize(params[:email])
        email = current_user.email if current_user
        subscription = CourseSubscriber.new(course_id: @course.id, email: email)

        if subscription.save
          render json: subscription, serializer: CourseSubscriberSerializer
        else
          render_error_response(subscription.errors.full_messages.first)
        end
      end

      def enroll
        @course = Course.find(params[:id])
        @participation = Participation.create(user_id: current_user.id, course_id: @course.id)
        render json: @participation, serializer: ParticipationsSerializer
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
