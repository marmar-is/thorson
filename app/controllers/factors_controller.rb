require_dependency 'exceptions'

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

  # DELETE /factors/:model/:id
  def destroy
    case params[:model]
    when "DedFactor"
      DedFactor.find(params[:id]).destroy
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
      Exceptions::UnrecognizedParameter("Unrecognized model parameter (FactorsController.rb:46)")
    end

    respond_to do |format|
      format.html { redirect_to factors_url, notice: 'Factor/Rate was successfully destroyed.' }
      format.js { }
    end
  end

  # PATCH /factors/:model/:id
  def update
    case params[:model]
    when "DedFactor"
      DedFactor.find(params[:id]).update(factor_params)
    when "EntityFactor"
      EntityFactor.find(params[:id]).update(factor_params)
    when "LimitFactor"
      LimitFactor.find(params[:id]).update(factor_params)
    when "StepFactor"
      StepFactor.find(params[:id]).update(factor_params)
    when "TerritoryFactor"
      TerritoryFactor.find(params[:id]).update(factor_params)
    when "SpecialtyFactor"
      SpecialtyFactor.find(params[:id]).update(factor_params)
    when "RiskFactor"
      RiskFactor.find(params[:id]).update(factor_params)
    when "NasRate"
      NasRate.find(params[:id]).update(factor_params)
    when "BaseRate"
      BaseRate.find(params[:id]).update(factor_params)
    when "AlliedRate"
      AlliedRate.find(params[:id]).update(factor_params)
    else
      Exceptions::UnrecognizedParameter("Unrecognized model parameter (FactorsController.rb:79)")
    end
  end

  # PATCH /factors/:model
  def create
    case params[:model]
    when "DedFactor"
      @factor = DedFactor.new
    when "EntityFactor"
      @factor = EntityFactor.new
    when "LimitFactor"
      @factor = LimitFactor.new
    when "StepFactor"
      @factor = StepFactor.new
    when "TerritoryFactor"
      @factor = TerritoryFactor.new
    when "SpecialtyFactor"
      @factor = SpecialtyFactor.new
    when "RiskFactor"
      @factor = RiskFactor.new
    when "NasRate"
      @factor = NasRate.new
    when "BaseRate"
      @factor = BaseRate.new
    when "AlliedRate"
      @factor = AlliedRate.new
    else
      Exceptions::UnrecognizedParameter("Unrecognized model parameter (FactorsController.rb:107)")
    end

    if @factor.save
      respond_to do |format|
        format.json { render json: @factor, status: :created }
      end
    else
      respond_to do |format|
        format.json { render json: @factor.errors, status: :created }
      end
    end

  end

  private
  def factor_params
    params.require(:factor).permit( :criteria, :min_factor, :max_factor, :group,
    :spec_name, :spec_surgery, :spec_class, :spec_code, :territory, :exposure,
    :number, :limit, :state, :deductible, :entity, :factor, :rate, constituents: [] )
  end

end
