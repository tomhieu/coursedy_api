module Api
  module V1
    class CategoriesController < ApiController
      skip_before_action :authenticate_user!

      def index
        render json: Category.where('category_id is null').includes(:course_levels, :children), each_serializer: CategoriesSerializer
      end
    end
  end
end
