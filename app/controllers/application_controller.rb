class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery with: :null_session

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role, :phone_number])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :address, :phone_number, :date_of_birth, :gender])
  end
end
