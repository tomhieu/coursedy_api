module Api
  module V1
    class LocationsController < ApiController
      skip_before_action :authenticate_user!

      def index
        render json: City.pluck(:id, :name).to_h
      end
    end
  end
end
