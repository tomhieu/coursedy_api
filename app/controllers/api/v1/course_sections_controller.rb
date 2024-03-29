module Api
  module V1
    class CourseSectionsController < ApiController
      def create
        authorize CourseSection
        @section = CourseSection.create(section_params)
        if @section.errors.messages.count > 0
          render_error_response(@section.errors.full_messages.first, :unprocessable_entity)
        else
          render json: @section, serializer: CourseSectionSerializer
        end
      end

      def show
        @section = CourseSection.find(params[:id])
        authorize @section
        render json: @section, serializer: CourseSectionSerializer
      end

      def index
        @sections = CourseSection.where(course_id: params[:course_id]).includes({lessons: :documents}, :course)
        @sections.each do |section|
          authorize section
        end
        render json: @sections, each_serializer: CourseSectionSerializer
      end

      def update
        @section = CourseSection.find(params[:id])
        authorize @section
        if @section.update_attributes(section_params)
          render json: @section, serializer: CourseSectionSerializer
        else
          render_error_response(@section.errors.full_messages.first, :unprocessable_entity)
        end
      end

      def destroy
        @section = CourseSection.find(params[:id])
        authorize @section
        @section.destroy
        render json: {id: @section.id}
      end

      private

      def section_params
        params.require(:course_section).permit(:title, :course_id)
      end
    end
  end
end