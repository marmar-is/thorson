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

  # DELETE /factors
  def destroy
    case params[:model]
    when "DedFactor"
      puts "DEDFACTOR"
      #DedFactor.find(params[:id]).destroy
    when "EntityFactor"
      EntityFactor.find(params[:id]).destroy
    when "LimitFactor"
      LimitFactor.find(params[:id]).destroy
    when "StepFactor"
      StepFactor.find(params[:id]).destroy
    when "TerritoryFactor"
      TerritoryFactor.find(params[:id]).destroy
    when "SpecialtyFactor"
      SpecialtyFactor.find(params[:id]).destroy
    when "RiskFactor"
      RiskFactor.find(params[:id]).destroy
    when "NasRate"
      NasRate.find(params[:id]).destroy
    when "BaseRate"
      BaseRate.find(params[:id]).destroy
    when "AlliedRate"
      AlliedRate.find(params[:id]).destroy
    else
      Exceptions::UnrecognizedParameter("Unrecognized model parameter (FactorsController.rb:)")
    end

    respond_to do |format|
      format.html { redirect_to factors_url, notice: 'Factor/Rate was successfully destroyed.' }
      format.js { }
    end
  end

end
