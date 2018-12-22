class CdAdmin::AdminController < ActionController::Base
  layout 'application'
  before_action :authenticate_cd_admin_user!
  before_action :check_duo

  def check_duo
    redirect_to cd_admin_duo_new_path unless session[:duo_user]
  end
end