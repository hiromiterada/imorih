class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :detect_devise_variant
  before_filter :set_locale

  rescue_from Exception do |ex|
    puts ex.message
    puts ex.class
    puts ex.backtrace.join("\n")
    raise ex
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) {|u| u.permit(
      :login, :customer_code, :email, :password, :remember_me
    )}
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(
      :customer_code, :email, :password
    )}
    devise_parameter_sanitizer.for(:account_update) << [
      :email, :lastname, :firstname, :locale, :gender, :birthday,
      :address, :phone, :send_of_dm
    ]
  end

  private

  def default_url_options(options={})
    { locale: I18n.locale }
  end

  def set_locale
    I18n.locale = locale_in_user_info || locale_in_params ||
      locale_in_accept_language || I18n.default_locale
  end

  def locale_in_user_info
    if user_signed_in?
      current_user.locale.to_sym
    else
      nil
    end
  end

  def locale_in_params
    if params[:locale].present?
      params[:locale].to_sym.presence_in(I18n::available_locales)
    else
      nil
    end
  end

  def locale_in_accept_language
    request.env['HTTP_ACCEPT_LANGUAGE']
      .to_s.split(',')
      .map { |_| _[0..1].to_sym }
      .select { |_| I18n::available_locales.include?(_) }
      .first
  end

  def detect_devise_variant
    case request.user_agent
    when /iPhone/, /Android.*Mobi/, /Windows.*Phone/, /Mobi.*Firefox/,
      /Nexus [4|5|6]/, /BlackBerry/
      request.variant = :mobile
    end
  end
end
