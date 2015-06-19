class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def ensure_signup_complete
    return if action_name == 'finish_signup'
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:name, :email, :first_name, :last_name, :gender, :date_of_birth, :country, :city]
  end
end
