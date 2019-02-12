class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_locale
  before_action :authenticate_user!
  before_action :configure_permited_parameters, if: :devise_controller?

  def after_sign_in_path_for(user)
    if user.admin?
      admin_tests_path
    else
      super
    end
  end

  def default_url_options
    { lang: I18n.locale }
  end

  private

  def configure_permited_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end

  def set_locale
    I18n.locale = I18n.locale_available?(params[:lang]) ? params[:lang] : I18n.default_locale
  end
end
