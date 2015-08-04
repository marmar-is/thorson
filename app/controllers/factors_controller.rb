class FactorsController < ApplicationController
  # ActionController Callbacks
  before_action :employee_access!

  # GET /factors
  def index
    @ded_factors         = DedFactor.all
    @entity_factors      = EntityFactor.all
    @limit_factors       = LimitFactor.all
    @step_factors        = StepFactor.all
    @territory_factors   = TerritoryFactor.all
    @spec_factors        = SpecialtyFactor.all
    @risk_factors        = RiskFactor.all

    @nas_rates           = NasRate.all
    @base_rates          = BaseRate.all
    @allied_rates        = AlliedRate.all
  end

end
