class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login, :first_name, :last_name, :phone])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone])
  end

  def current_user_is_not_admin?
    redirect_root_with_error_message and return unless current_user.admin?
  end

  def redirect_root_with_error_message
    flash[:alert] = "No tienes permiso para realizar esta acción"

    redirect_to root_path
  end
end
