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
=begin
        # Create a new rating (save all rates/factors at the time)
        nas_r         = NasRate.where(limit: @risk_profile.limit_nas).first.rate
        base_r        = BaseRate.where(state: @risk_profile.state).first.rate
        allied1_r     = AlliedRate.where(group: 'allied1').first.rate
        allied2_r     = AlliedRate.where(group: 'allied2').first.rate
        allied3_r     = AlliedRate.where(group: 'allied3').first.rate

        limit_f       = LimitFactor.where(limit: @risk_profile.limit, state: @risk_profile.state).first.factor

        physician_p   = (base_r * spec_f * territy_f * ded_f * step_f)
        allied_p      = (allied1_r * @risk_profile.allied1 * allied2_r * @risk_profile.allied2 * allied3_r * @risk_profile.allied3)
        fairway_p     = (((physician_p * risk_f * entity_f) + !!entity_premium!!) * limit_f)
        capital_c     = (0)

        @risk_profile.ratings.create!(risk_prof: @risk_profile.attributes,
        rates: {
          nas_rate: nas_r,
          base_rate: base_r,
          allied1_rate: allied1_r, allied2_rate: allied2_r, allied3_rate: allied3_r
        },
        factors: {

        }
        policy_year: 1, capital: true,

        physician_premium:    physician_p,
        allied_premium:       allied_p,
        nas_premium:          nas_r,
        fairway_premium:      fairway_p,
        total_premium:        (fairway_p + capital_c + nas_r),
        capital_contribution: capital_c
        )
=end
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
