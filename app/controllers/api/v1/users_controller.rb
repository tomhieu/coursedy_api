module Api
  module V1
    class UsersController < ApiController
      skip_before_action :authenticate_user!, only: [:validate_email]

      def current_api_user
        if current_user
          render json: current_user, serializer: UsersSerializer
        else
          render_error_response('not login', :not_found)
        end
      end

      def enrolled_courses
        render json: current_user.enrolled_courses.includes(:tutor, :category, :course_level, :week_day_schedules),
               each_serializer: CoursesSerializer
      end

      def validate_email
        if User.exists?(email: ActionView::Base.full_sanitizer.sanitize(params[:email]))
          render json: {valid: false}
        else
          render json: {valid: true}
        end
      end
    end
  end
end
