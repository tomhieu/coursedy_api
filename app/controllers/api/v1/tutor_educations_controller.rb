module Api
  module V1
    class TutorEducationsController < ApiController
      def create
        @education = TutorEducation.new(tutor_education_params)
        @education.tutor_id = params[:tutor_id]
        @education.save

        if @education.errors.messages.count > 0
          render_error_response(@education.errors.full_messages.first, :unprocessable_entity)
        else
          render json: @education, serializer: TutorEducationsSerializer
        end
      end

      def show
        @education = TutorEducation.find(params[:id])
        render json: @education, serializer: TutorEducationsSerializer
      end

      def index
        @educations = TutorEducation.where(tutor_id: params[:tutor_id])
        render json: @educations, each_serializer: TutorEducationsSerializer
      end

      def update
        @education = TutorEducation.find(params[:id])

        if @education.update_attributes(tutor_education_params)
          render json: @education, serializer: TutorEducationsSerializer
        else
          render_error_response(@education.errors.full_messages.first, :unprocessable_entity)
        end
      end

      def destroy
        @education = TutorEducation.find(params[:id])
        @education.destroy
        render json: {id: @education.id}
      end

      private

      def tutor_education_params
        params.require(:tutor_education).permit(:title, :start_date, :end_date, :graduated_from, :description, :tutor_id)
      end
    end
  end
end