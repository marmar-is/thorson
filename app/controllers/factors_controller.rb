class FactorsController < ApplicationController
  before_action :employee_access!

  # GET /factors
  def index
    @ded_factors = DedFactor.all
    @entity_factors = EntityFactor.all
    @limit_factors = LimitFactor.all
  end

  protected
  def employee_access!
    if account_signed_in? && !current_account.admin? && !current_account.employee?
      begin
        redirect_to :back, notice: 'You are attempting to access an employee-only zone.'
      rescue
        redirect_to "/", notice: 'You are attempting to access an employee-only zone.'
      end
    end
  end
end
