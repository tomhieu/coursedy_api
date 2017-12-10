module Api
  module V1
    class CoursesController < ApiController
      skip_before_action :authenticate_user!, only: [:follow]

      def index
        render json: Course.includes(:tutor, :category, :course_level).all, each_serializer: CoursesSerializer
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
        params.require(:course).permit(:title, :description, :start_date, :end_date,
                      :number_of_students, :period, :period_type, :tuition_fee, :category_id,
                      :course_level_id, :currency, :cover_image
        )
      end
    end
  end
end
