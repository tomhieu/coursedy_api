module Api
  module V1
    class TutorsController < ApiController
      skip_before_action :authenticate_user!, only: [:tutor_by_user]

      def current_tutor
        render json: current_user.tutor, serializer: TutorsSerializer
      end

      def update
        @tutor = Tutor.find(params[:id])
        @tutor.update_attributes(tutor_params)

        categories  = Category.where(id: params[:categories])
        @tutor.categories = categories
        @tutor.save

        render json: @tutor, serializer: TutorsSerializer
      end

      def tutor_by_user
        @tutor = User.find(params[:user_id]).tutor
        render json: @tutor, serializer: TutorsSerializer
      end

      private

      def tutor_params
        params.require(:tutor).permit(:name, :title, :speciality, :description, :categories)
      end
    end
  end
end