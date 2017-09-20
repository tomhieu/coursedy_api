module Api
  module V1
    class UsersController < ApiController
      def current_api_user
        if current_user
          render json: current_user, each_serializer: UsersSerializer
        else
          render json: {}
        end
      end
    end
  end
end
