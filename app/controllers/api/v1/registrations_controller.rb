module Api
  module V1
    class RegistrationsController < DeviseTokenAuth::RegistrationsController
      def create
        super
      end

      def render_update_success
        render json: @resource.reload, serializer: UsersSerializer
      end

      def update_resource(resource, params)
        return super if params["password"]&.present?

        # Allows user to update registration information without password.
        resource.update_without_password(params.except("current_password"))
      end

      private

      def user_params
        params.require(:registration).permit(
          :name, :address, :phone_number,
          :date_of_birth, :gender, :current_password,
          :password_confirmation, :password, :avatar
        )
      end
    end
  end
end