class CdAdmin::AdminController < ActionController::Base
  layout 'application'
  before_action :authenticate_cd_admin_user!
  before_action :check_admin
  before_action :check_duo

  private
  def check_admin
    redirect_to '/404.html' unless current_cd_admin_user.has_role? :admin
  end

  def check_duo
    redirect_to cd_admin_duo_new_path unless session[:duo_user]
  end
end