module Api
  module V1
    class PasswordsController < DeviseTokenAuth::PasswordsController
      def edit
        @resource = with_reset_password_token(resource_params[:reset_password_token])

        if @resource && @resource.reset_password_period_valid?
          client_id, token = @resource.create_token

          # ensure that user is confirmed
          @resource.skip_confirmation! if confirmable_enabled? && !@resource.confirmed_at

          @resource.save!

          yield @resource if block_given?

          redirect_header_options = {reset_password: true}
          redirect_headers = build_redirect_headers(token,
                                                    client_id,
                                                    redirect_header_options)
          frontend = AppSettings.frontend
          edit_password_url = frontend.host + frontend.edit_password_path

          redirect_to(@resource.build_auth_url(edit_password_url,
                                               redirect_headers))
        else
          render_edit_error
        end
      end
    end
  end
end