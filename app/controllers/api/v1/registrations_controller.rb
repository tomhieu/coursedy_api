module Api
  module V1
    class RegistrationsController < DeviseTokenAuth::RegistrationsController
      def create
        super
      end

      def render_update_success
        render json: @resource.reload, serializer: UsersSerializer
      end
    end
  end
end