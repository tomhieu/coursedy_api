module Api
  module V1
    class ChangePasswordRequestsController < ApiController
      skip_before_action :authenticate_user!, only: [:create]

      def create
        @resource = User.find_by(email: params[:email])
        if @resource
          @resource.send_reset_password_instructions
          render json: {success: true}
        else
          render_error_response(I18n.t("common_errors.email_not_found"), 404)
        end
      end
    end
  end
end