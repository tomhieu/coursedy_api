module Api
  module V1
    class TutorsController < ApiController
      skip_before_action :authenticate_user!, only: [:tutor_by_user, :top_teachers, :index, :show, :search]

      def current_tutor
        render json: current_user.tutor, serializer: TutorsSerializer
      end

      def search
        categories = (params[:categories] || []) + (params[:specializes] || [])

        solr_search = Tutor.search do
          fulltext params[:q]

          if !categories.blank?
            with(:category_id, params[:categories])
          end

          paginate :page => params[:page] || 1, :per_page => params[:per_page] || 10
        end

        @tutors = paginate Tutor.where(id: solr_search.results.map(&:id)).includes(:user, :categories, :degrees)

        render json: @tutors, each_serializer: TutorsSerializer, full_info: true
      end

      def index
        @tutors = paginate Tutor.all.includes(:user, :categories, :degrees)
        render json: @tutors, each_serializer: TutorsSerializer, full_info: true
      end

      def show
        @tutor = Tutor.find(params[:id])
        render json: @tutor, serializer: TutorsSerializer, full_info: true
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
        params.require(:tutor).permit(:name, :title, :place_of_work, :speciality, :description, :categories)
      end
    end
  end
end