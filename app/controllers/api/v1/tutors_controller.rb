module Api
  module V1
    class TutorsController < ApiController
      skip_before_action :authenticate_user!, only: [:tutor_by_user, :top_teachers]

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

      def top_teachers
        top_tutors = Tutor.joins(user: :tutor_ratings).order('tutor_ratings.points desc').limit(20)

        render json: top_tutors, each_serializer: TutorsSerializer
      end

      private

      def tutor_params
        params.require(:tutor).permit(:name, :title, :speciality, :description, :categories)
      end
    end
  end
end