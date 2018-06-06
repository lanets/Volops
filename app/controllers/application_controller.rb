class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  check_authorization unless: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    flash[:warning] = exception.message
    redirect_to root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :number, :birthday, :role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :number, :birthday, :role])
  end
end
