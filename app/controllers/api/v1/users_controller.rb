module Api
  module V1
    class UsersController < ApiController
      skip_before_action :authenticate_user!, only: [:validate_email, :get_rating]

      def current_api_user
        if current_user
          render json: current_user, serializer: UsersSerializer
        else
          render_error_response('not login', :not_found)
        end
      end

      def connect_facebook
        if !params[:email] || !params[:name] || !params[:token] || !FacebookService.verify_user_token(params[:token], params[:app_user_id])
          render_error_response('Unauthorized', 401) and return
        end

        if user = User.find_by(email: params[:email])
          user.facebook_id = params[:app_user_id]
          user.save
        else
          user = User.create(
            email: params[:email],
            password: SecureRandom.hex(20),
            name: params[:name],
            facebook_id: params[:app_user_id]
          )
        end

      end

      def accounts
        @accounts = current_user.accounts
        render json: @accounts, each_serializer: AccountsSerializer
      end

      def enrolled_courses
        render json: current_user.enrolled_courses.includes(:user, :category, :course_level, :week_day_schedules),
               each_serializer: CoursesSerializer, full_info: true
      end

      def followed_courses
        render json: current_user.followed_courses.includes(:user, :category, :course_level, :week_day_schedules),
               each_serializer: CoursesSerializer, full_info: true
      end

      def courses
        if params[:id].present?
          @courses = Course.where(user_id: params[:id])
        else
          @courses = Course.unscoped.where(user_id: current_user.id)
        end

        @courses = @courses.includes(:user, :category, :course_level, :week_day_schedules)

        unless params[:status].blank?
          @courses = @courses.where(status: params[:status])
        end

        @courses = paginate @courses
        render json: @courses, each_serializer: CoursesSerializer, full_info: true
      end

      def rate_teacher
        course = Course.find(params[:course_id])
        rating = TutorRating.create(
          course_id: course.id,
          points: params[:points],
          teacher_id: course.user_id,
          user_id: current_api_user.id
        )

        if rating.errors
          render_error_response(rating.errors.first, :unprocessable_entity)
        else
          render json: rating, serializer: TutorRatingsSerializer
        end
      end

      def get_rating
        user = User.find(params[:id])
        if user.tutor_ratings.count == 0
          render json: {rating: 0} and return
        end

        user.tutor_ratings.sum(:points).to_f/user.tutor_ratings.count
        render json: {rating: 1}
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
