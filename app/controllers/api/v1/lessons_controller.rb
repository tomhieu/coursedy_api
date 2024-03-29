module Api
  module V1
    class LessonsController < ApiController
      def create
        authorize Lesson

        @lesson = Lesson.create(lesson_params)
        if @lesson.errors.messages.count > 0
          render_error_response(@lesson.errors.full_messages.first, :unprocessable_entity)
        else
          render json: @lesson, serializer: LessonsSerializer
        end
      end

      def show
        @lesson = Lesson.find(params[:id])
        authorize @lesson
        render json: @lesson, serializer: LessonsSerializer
      end

      def index
        @lessons = Lesson.where(section_id: params[:section_id]).includes(:documents)
        @lessons.each do |lesson|
          authorize lesson, :show?
        end

        render json: @lessons, each_serializer: LessonsSerializer
      end

      def update
        @lesson = Lesson.find_by(id: params[:id])

        authorize @lesson

        if @lesson.update_attributes(lesson_params)
          render json: @lesson, serializer: LessonsSerializer
        else
          render_error_response(@lesson.errors.full_messages.first, :unprocessable_entity)
        end
      end

      def destroy
        @lesson = Lesson.find(params[:id])
        authorize @lesson

        @lesson.destroy
        render json: {id: @lesson.id}
      end

      private

      def lesson_params
        params.require(:lesson).permit(:title, :course_id, :course_section_id, :period, :description, :published, :status)
      end
    end
  end
end