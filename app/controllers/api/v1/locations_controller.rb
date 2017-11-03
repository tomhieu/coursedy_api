module Api
  module V1
    class LocationsController < ApiController
      skip_before_action :authenticate_user!

      def index
        render json: Course::LOCATIONS
      end
    end
  end
end
