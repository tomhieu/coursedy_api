class CdAdmin::DuoController < CdAdmin::AdminController
  skip_before_action :check_duo, only: [:new, :verify]

  def new
    duo_settings = AppSettings.duo
    @sig_request = Duo.sign_request(duo_settings.ikey, duo_settings.skey, duo_settings.akey, current_cd_admin_user.email)
  end

  def verify
    duo_settings = AppSettings.duo
    if (email = Duo.verify_response(duo_settings.ikey, duo_settings.skey, duo_settings.akey, params[:sig_response])).present?
      session[:duo_user] = email
      redirect_to cd_admin_pages_path
    else
      redirect_to cd_admin_duo_new_path, alert: 'invalid code'
    end
  end
end