class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_all!

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    unauthenticated_root_path
  end

  protected
  def devise_parameter_sanitizer
    if resource_class == User
      UserParams.new(User, :user, params)
    else
      super # Use the default one
    end
  end

  private
  def authenticate_all!(opts = {})
    if !account_signed_in? && action_name != 'portal' && !devise_controller?
      redirect_to :unauthenticated_root
    end
  end
end
