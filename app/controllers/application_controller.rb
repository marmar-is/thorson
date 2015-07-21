class ApplicationController < ActionController::Base
  rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render :text => exception, :status => 500
  end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #before_action :authenticate_user!

  protected
  def devise_parameter_sanitizer
    if resource_class == User
      UserParams.new(User, :user, params)
    else
      super # Use the default one
    end
  end

end
