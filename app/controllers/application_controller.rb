# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
  check_authorization unless: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    flash[:warning] = exception.message
    redirect_back(fallback_location: root_path)
  end

  def herd_user
    redirect_back(fallback_location: root_path) unless current_user.is?(:admin)
  end

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(locale) ?
        locale :
        I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name number birthday role])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name number birthday role])
  end
end
