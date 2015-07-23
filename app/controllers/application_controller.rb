class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_account!

  def after_sign_in_path_for(resource)

    if current_account.admin?
      
    elsif current_account.broker?

      if current_account.broker_acct.nil?
        redirect_to new_broker_path
      else
        redirect_to new_risk_profile_path
      end

    elsif current_account.employee?
      redirect_to factors_path
    else
      raise AbstractController::ActionNotFound
    end

  end

  protected
  def devise_parameter_sanitizer
    if resource_class == User
      UserParams.new(User, :user, params)
    else
      super # Use the default one
    end
  end

  def authenticate_account!
    if !account_signed_in? && action_name != 'portal' && !devise_controller?
      redirect_to :unauthenticated_root
    end
  end
end
