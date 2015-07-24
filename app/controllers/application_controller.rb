class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_account!
  before_action :authenticate_meta!, if: :account_signed_in?
  before_action :set_acct!, if: :account_signed_in?

  def after_sign_in_path_for(resource)
    if current_account.admin?
      "/"
    elsif current_account.broker?
      "/"
    elsif current_account.employee?
      "/"
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

  def authenticate_meta!
    if current_account.broker? && current_account.meta.nil?
      redirect_to new_broker_acct_path, notice: 'You must complete your broker profile to continue.'
    elsif current_account.employee? && current_account.meta.nil?
      redirect_to new_employee_acct_path, notice: 'You must verify your employee profile to continue.'
    end
  end

  def broker_access!
    if account_signed_in? && !current_account.broker? && !current_account.admin?
      begin
        redirect_to :back, notice: 'You are attempting to access a broker-only zone.'
      rescue
        redirect_to "/", notice: 'You are attempting to access a broker-only zone.'
      end
    end
  end

  def employee_access!
    if account_signed_in? && !current_account.employee? && !current_account.admin?
      begin
        redirect_to :back, notice: 'You are attempting to access an employee-only zone.'
      rescue
        redirect_to "/", notice: 'You are attempting to access an employee-only zone.'
      end
    end
  end

  def set_acct!
    @acct = current_account.meta
  end
end
