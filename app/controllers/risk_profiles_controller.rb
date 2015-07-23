class RiskProfilesController < ApplicationController
  before_action :set_risk_profile, only: [:show, :edit, :update, :destroy]

  # GET /risk_profiles
  # GET /risk_profiles.json
  def index
    @risk_profiles = current_account.broker.risk_profiles
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
    @risk_profile = RiskProfile.new(risk_profile_params)

    respond_to do |format|
      if @risk_profile.save
        format.html { redirect_to @risk_profile, notice: 'Risk profile was successfully created.' }
        format.json { render :show, status: :created, location: @risk_profile }
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
      params.require(:risk_profile).permit(:name, :county, :state, :effective, :retro, :specialty, :deductible, :limits, :limit_nas, :entity, :allied1, :allied2, :allied3, :sub_specialty)
    end
end
