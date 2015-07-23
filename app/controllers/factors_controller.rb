class FactorsController < ApplicationController
  before_action :authenticate_role!

  # GET /factors
  def index
  end

  private
  def authenticate_role!
    if !current_account.admin? && !current_account.employee?
      raise ActionController::RoutingError.new('Unauthorized Access.')
    end
  end
end
