class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :phone, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login, :first_name, :last_name, :email, :phone, :password])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :email, :phone, :password, :password_confirmation, :current_password])
  end
end
