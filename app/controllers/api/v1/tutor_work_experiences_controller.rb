module Api
  module V1
    class TutorWorkExperiencesController < ApiController
      def create
        @experience = TutorWorkExperience.new(tutor_education_params)
        @experience.tutor_id = params[:tutor_id]
        @experience.save

        if @experience.errors.messages.count > 0
          render_error_response(@experience.errors.full_messages.first, :unprocessable_entity)
        else
          render json: @experience, serializer: TutorWorkExperiencesSerializer
        end
      end

      def show
        @experience = TutorWorkExperience.find(params[:id])
        render json: @experience, serializer: TutorWorkExperiencesSerializer
      end

      def index
        @experiences = TutorWorkExperience.where(tutor_id: params[:tutor_id])
        render json: @experiences, each_serializer: TutorWorkExperiencesSerializer
      end

      def update
        @experience = TutorWorkExperience.find(params[:id])

        if @experience.update_attributes(tutor_work_experience_params)
          render json: @experience, serializer: TutorWorkExperiencesSerializer
        else
          render_error_response(@experience.errors.full_messages.first, :unprocessable_entity)
        end
      end

      def destroy
        @experience = TutorWorkExperience.find(params[:id])
        @experience.destroy
        render json: {id: @experience.id}
      end

      private

      def tutor_work_experience_params
        params.require(:tutor_work_experience).permit(:title, :start_date, :end_date, :company, :description, :tutor_id)
      end
    end
  end
end