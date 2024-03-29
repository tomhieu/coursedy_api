class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit
  protect_from_forgery with: :null_session

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role, :phone_number, :country_code])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :country_code, :address, :phone_number, :date_of_birth, :gender, :current_password, :password_confirmation, :password, :avatar])
  end
end
