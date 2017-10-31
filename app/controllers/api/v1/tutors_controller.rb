module Api
  module V1
    class TutorsController < ApiController
      def current_tutor
        render json: current_user.tutor, serializer: TutorsSerializer
      end

      def update
        @tutor = Tutor.find(params[:id])
        @tutor.update_attributes(tutor_params)
        render json: @tutor, serializer: TutorsSerializer
      end

      private

      def tutor_params
        params.require(:tutor).permit(:name, :title, :speciality, :description)
      end
    end
  end
end