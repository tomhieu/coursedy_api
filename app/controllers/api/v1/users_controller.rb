module Api
  module V1
    class UsersController < ApiController
      def current_api_user
        if current_user
          render json: current_user, each_serializer: UsersSerializer
        else
          render_error_response('not login', :not_found)
        end
      end
    end
  end
end
