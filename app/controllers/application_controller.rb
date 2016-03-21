class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

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
      :lastname, :firstname, :locale, :gender, :birthday,
      :address, :phone, :send_of_dm
    ]
  end
end
