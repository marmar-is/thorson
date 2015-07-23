class RiskProfilesController < ApplicationController
  before_action :set_risk_profile, only: [:show, :edit, :update, :destroy]

  # GET /risk_profiles
  # GET /risk_profiles.json
  def index
    @risk_profiles = @acct.risk_profiles
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

        # Create a new rating (save all rates/factors at the time)
        nas_rate    = NasRate.where(limit: @risk_profile.limit_nas).first.rate
        base_rate   = BaseRate.where(state: @risk_profile.state).first.rate
        allied1     = AlliedRate.where(group: 'allied1').first.rate
        allied2     = AlliedRate.where(group: 'allied2').first.rate
        allied3     = AlliedRate.where(group: 'allied3').first.rate



        physician_p = (base_rate * spec_factor * territy_factor * ded_factor * step_factor)
        allied_p    = (allied1 * @risk_profile.allied1 * allied2 * @risk_profile.allied2 * allied3 * @risk_profile.allied3)
        fairway_p   = (((physician_p * risk_factor * entity_factor) + !!entity_premium!!) * limit_factor)
        capital_c   = (0)

        @risk_profile.ratings.create!(risk_prof: @risk_profile.attributes,
        rates: {
          nas_rate: nas_rate,
          base_rate: base_rate,
          allied1_rate: allied1, allied2_rate: allied2, allied3_rate: allied3
        },
        factors: {

        }
        policy_year: 1, capital: true,
        
        physician_premium:    physician_p,
        allied_premium:       allied_p,
        nas_premium:          nas_rate,
        fairway_premium:      fairway_p,
        total_premium:        (fairway_p + capital_c + nas_rate),
        capital_contribution: capital_c
        )

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
end
