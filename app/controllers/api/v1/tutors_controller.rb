module Api
  module V1
    class TutorsController < ApiController
      skip_before_action :authenticate_user!, only: [:tutor_by_user, :top_teachers, :index, :show, :search, :courses]

      def current_tutor
        @current_tutor = Tutor.unscoped.where(user_id: current_user.id)
                             .includes(:user, :categories, :degrees).first
        render json: @current_tutor, serializer: TutorsSerializer
      end

      def search
        specializes = params[:specializes] || []
        categories = params[:categories] || []

        if specializes.blank?
          sub_categories = Category.where(category_id: categories).map(&:id)
          categories += sub_categories
        else
          categories += specializes
        end

        solr_search = Tutor.search do
          fulltext params[:q]

          if !categories.blank?
            with(:category_id, categories)
          end

          with(:status, Tutor::VERIFIED)

        end

        @tutors = paginate Tutor.where(id: solr_search.results.map(&:id)).includes(:user, :categories, :degrees)

        @tutors.each do |tutor|
          authorize tutor, :show?
        end

        render json: @tutors, each_serializer: TutorsSerializer, full_info: true
      end

      def courses
        tutor = Tutor.find(params[:id])
        @courses = Course.where(user_id: tutor.user_id)

        @courses = @courses.includes(:user, :category, :course_level, :week_day_schedules)

        unless params[:status].blank?
          @courses = @courses.where(status: params[:status])
        end

        @courses = paginate @courses
        render json: @courses, each_serializer: CoursesSerializer, full_info: true
      end

      def index
        if params[:status]
          @tutors = paginate Tutor.where(status: params[:status]).includes(:user, :categories, :degrees)
        else
          @tutors = paginate Tutor.all.includes(:user, :categories, :degrees)
        end

        render json: @tutors, each_serializer: TutorsSerializer, full_info: true
      end

      def show
        @tutor = Tutor.friendly.find(params[:id])
        authorize @tutor
        render json: @tutor, serializer: TutorsSerializer, full_info: true
      end

      def update
        @tutor = Tutor.unscoped.find(params[:id])
        authorize @tutor
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
        params.require(:tutor).permit(:name, :title, :place_of_work, :speciality, :description, :categories, :facebook, :linkedin, :google_plus, :tweeter)
      end
    end
  end
end