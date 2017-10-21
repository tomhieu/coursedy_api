module Api
  module V1
    class CoursesController < ApiController
      def create
        @course = Course.new(course_params)
        @course.user_id = current_user.id

        if @course.save
          render json: @course, serializer: CoursesSerializer
        else
          render_error_response(@course.errors, :unprocessable_entity)
        end
      end

      private

      def course_params
        params.require(:course).permit(:title, :description, :start_date, :end_date,
                      :number_of_students, :period, :period_type, :tuition_fee,
                      :currency, :cover_image
        )
      end
    end
  end
end
