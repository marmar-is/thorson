class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_account!
  before_action :authenticate_broker!
  before_action :set_acct!

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

  def authenticate_broker!
    if account_signed_in? && current_account.broker? && current_account.meta.nil?
      redirect_to new_broker_acct_path, notice: 'You must create an account to continue.'
    end
  end

  def set_acct!
    @acct = current_account.meta
  end
end
