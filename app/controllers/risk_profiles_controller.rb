class RiskProfilesController < ApplicationController
  before_action :broker_access!, only: [ :new, :create ]
  before_action :set_risk_profile, only: [:show, :edit, :update, :destroy]

  # GET /risk_profiles
  # GET /risk_profiles.json
  def index
    if current_account.broker?
      @risk_profiles = @acct.risk_profiles
    elsif current_account.employee?
      @risk_profiles = RiskProfile.all
    else
      @risk_profiles = RiskProfile.all
    end
  end

  # GET /risk_profiles/1
  # GET /risk_profiles/1.json
  def show
  end

  # GET /risk_profiles/new
  def new
    @risk_profile = RiskProfile.new
    @spec_names = SpecialtyFactor.pluck(:spec_name)
    @limits = LimitFactor.pluck(:limit)
    @nases = NasRate.pluck(:limit)
  end

  # GET /risk_profiles/1/edit
  def edit
  end

  # POST /risk_profiles
  # POST /risk_profiles.json
  def create
    @spec_names = SpecialtyFactor.pluck(:spec_name)
    @limits = LimitFactor.pluck(:limit)
    @nases = NasRate.pluck(:limit)

    @risk_profile = RiskProfile.new(risk_profile_params)
    @risk_profile.broker_acct = @acct

    respond_to do |format|
      if @risk_profile.save

        calculate_rating()

        format.html { redirect_to risk_profiles_path, notice: 'Risk profile was successfully created.' }
        format.json { render :index, status: :created, location: @risk_profile }
      else
        format.html { render :new }
        format.json { render json: @risk_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /risk_profiles/1
  # PATCH/PUT /risk_profiles/1.json
  def update
    respond_to do |format|
      if @risk_profile.update(risk_profile_params)
        format.html { redirect_to @risk_profile, notice: 'Risk profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @risk_profile }
      else
        format.html { render :edit }
        format.json { render json: @risk_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /risk_profiles/1
  # DELETE /risk_profiles/1.json
  def destroy
    @risk_profile.destroy
    respond_to do |format|
      format.html { redirect_to risk_profiles_url, notice: 'Risk profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_risk_profile
      @risk_profile = RiskProfile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def risk_profile_params
      params.require(:risk_profile).permit(:name, :county, :state, :territory, :effective, :retro, :specialty, :specialty_surgery, :deductible, :limit, :limit_nas, :entity, :allied1, :allied2, :allied3, :sub_specialty, :capital, :license )
    end

    def calculate_rating
      # Create a new rating (save all rates/factors at the time)
      capital_f     = 0.10 # Capital Rate is 10%

      nas_r         = NasRate.where(limit: @risk_profile.limit_nas).first.rate
      base_r        = BaseRate.where(state: @risk_profile.state).first.rate
      allied1_r     = AlliedRate.where(group: 'allied1').first.rate
      allied2_r     = AlliedRate.where(group: 'allied2').first.rate
      allied3_r     = AlliedRate.where(group: 'allied3').first.rate

      limit_f       = LimitFactor.where(limit: @risk_profile.limit, state: @risk_profile.state).first.factor
      deductible_f  = DeductibleFactor.where(deductible: @risk_profile.deductible).first.factor
      step_f        = StepFactor.where(policy_year: "1", state: @risk_profile.state).first.factor
      #risk_f        = RiskFactor.where

      entity_f      = EntityFactor.where(entity: @risk_profile.entity).first.factor
      entity_p      = 0

      spec          = SpecialtyFactor.where(spec_name: @risk_profile.specialty).first
      specialty_f   = spec.factor
      specialty_c   = spec.spec_class

      territory     = TerritoryFactory.where(territory: @risk_profile.county, state: @risk_profile.state).first
      territory_n   = territory.number
      territory_e   = territory.exposure
      territory_f   = territory.factor

      physician_p   = (base_r * spec_f * territy_f * ded_f * step_f)
      allied_p      = (allied1_r * @risk_profile.allied1 * allied2_r * @risk_profile.allied2 * allied3_r * @risk_profile.allied3)
      fairway_p     = (((physician_p * risk_f * entity_f) + entity_p) * limit_f)
      capital_c     = (capital_f * fairway_p)

      @risk_profile.ratings.create!(
        # @rating = Rating.new(
        risk_profile_id: @risk_profile.id,
        risk_prof: @risk_profile.attributes,
        rates: {
          nas_rate:     nas_r,
          base_rate:    base_r,
          allied1_rate: allied1_r, allied2_rate: allied2_r, allied3_rate: allied3_r,
        },
        factors: {
          limit_factor:       limit_f,
          entity_factor:      entity_f,
          deductible_factor:  deductible_f,
          specialty_factor:   specialty_f,
          specialty_class:    specialty_c,
          step_factor:        step_f,
          capital_factor:     CAPITAL_F,
          #risk_factor:       risk_f,
          territory_number:   territory_n,
          territory_exposure: territory_e,
          territory_factor:   territory_f
        },
        policy_year: 1,
        capital: true,
        physician_premium:    physician_p,
        allied_premium:       allied_p,
        nas_premium:          nas_r,
        fairway_premium:      fairway_p,
        total_premium:        (fairway_p + capital_c + nas_r),
        capital_contribution: capital_c
      )
    end
end
