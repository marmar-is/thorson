require_dependency 'exceptions'

class RiskProfilesController < ApplicationController

  before_action :broker_access!, only: [ :new, :create ]
  before_action :set_risk_profile, only: [ :show, :edit, :update, :destroy, :update_status,
    :create_quote, :issue_quote, :view_quote ]

  before_action :broker_possession!, only: [ :show, :view_quote ]

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
    #@quote = Quote.new
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
      if @risk_profile.valid?

        calculate_rating()

        @rating.save
        @risk_profile.ratings << @rating

        if @risk_profile.save # should always save!
          DefaultMailer.send_new_risk_email(@risk_profile, Account.where(role: 2).pluck(:email) ).deliver

          format.html { redirect_to risk_profiles_path, notice: 'Risk profile was successfully created.' }
          format.json { render :index, status: :created, location: @risk_profile }
        end
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

  # PATCH /risk_profiles/1/update_status
  def update_status
    # Ensure evil parameters are not injected (i.e. raise error if protocol is broken)
    raise Exceptions::UnauthorizedAccountRole("(RiskProfilesController.rb:99)") if (params[:new_status] == 'withdrawn' && !current_account.broker?)
    raise Exceptions::UnauthorizedAccountRole("(RiskProfilesController.rb:100)") if (params[:for] == 'risk_profile' && (params[:new_status] == 'accepted' || params[:new_status] == 'declined') && !current_account.employee?)

    case params[:for]
    when "risk_profile"
      @risk_profile.update(status: params[:new_status], status_date: Time.now)
    when "rating"
      @risk_profile.ratings.last.update(status: params[:new_status], status_date: Time.now)
    when "quote"
      @risk_profile.ratings.last.quotes.last.update(status: params[:new_status], status_date: Time.now)
    else
      raise Exceptions::UnrecognizedParameter("for isn't 'risk_profile' or 'rating' (RiskProfilesController.rb:110)")
    end

    DefaultMailer.send_risk_status_update_email(@risk_profile).deliver

    respond_to do |format|
      format.html { redirect_to @risk_profile, notice: "Risk profile was successfully #{params[:new_status]}." }
      format.js
    end
  end

  # POST /risk_profiles/1/create_quote
  def create_quote
    @quote = Quote.new(quote_params)

    # Input Tags
    @quote.addl_shared = params[:quote][:addl_shared].split(',')
    @quote.addl_separate = params[:quote][:addl_separate].split(',')
    @quote.excl_locations = params[:quote][:excl_locations].split(',')
    @quote.excl_procedures = params[:quote][:excl_procedures].split(',')
    @quote.subjectivities = params[:quote][:subjectivities].split(',')

    # Multi Selects
    @quote.addl_employment = params[:quote][:additions].include?('Employment')
    @quote.addl_electronic = params[:quote][:additions].include?('Electronic')
    @quote.addl_medefense = params[:quote][:additions].include?('Medefense')
    @quote.addl_sexual = params[:quote][:additions].include?('Sexual')
    @quote.policy_forms = params[:quote][:policy_forms].reject(&:empty?)

    @quote.rating = Rating.find(params[:rating_id])

    respond_to do |format|
      if @quote.save
        format.html { redirect_to @quote.rating.risk_profile, notice: "Quote was successfully saved." }
        format.js
      else
        format.html { render :show }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH /risk_profiles/1/issue_quote
  def issue_quote
    # catch any errors
    raise Exceptions::UnrecognizedParameter("last rating isn't determined (RiskProfilesController.rb:155)") if !@risk_profile.ratings.last.determined?

    quote = @risk_profile.ratings.last.quotes.last

    pdftk = PdfForms.new(ENV['PDFTK_PATH'] || '/usr/local/bin/pdftk')

    fields = {
      INSURED_NAMED:          @risk_profile.name,
      INSURED_SPECIALTY:      @risk_profile.specialty,
      INSURED_ADDITIONAL:     quote.addl_separate.join(', ') + ', ' + quote.addl_shared.join(', '),
      PREMIUM:                quote.fairway_premium,
      CAPITALCONTRIBUTION:    quote.capital_contribution,
      BROKER_FEE:             quote.broker_fee,
      BROKER_COMMISSION:      quote.broker_commission,
      EFFECTIVE:              quote.effective.strftime('%d/%m/%Y'),
      RETROACTIVE:            quote.retro.strftime('%d/%m/%Y'),
      DEDUCTIBLE:             quote.deductible,
      LIMIT:                  quote.limit,
      EXCLUSIONS_PROCEDURES:  quote.excl_procedures.join(', '),
      EXCLUSIONS_LOCATIONS:   quote.excl_locations.join(', ')
    }

    i = 0
    addls = [
      ['addl_employment', 'Additional Insured Employment', 'Additional Insured Employment Description' ],
      ['addl_electronic', 'Additional Insured Electronic', 'Additional Insured Electronic Description' ],
      ['addl_medefense',  'Additional Insured Medefense',  'Additional Insured Medefense Description'  ],
      ['addl_sexual',     'Additional Insured Sexual',     'Additional Insured Sexual Description'     ]
    ]
    addls.each do |a|
      if quote[a[0]]
        fields["ADDITIONAL COVERAGE.#{i}"] = a[1]
        fields["ADDITIONAL COVERAGE DESCRIPTION.#{i}"] = a[2]
        i += 1
      end
    end

    quote.subjectivities.each_with_index do |s, i|
      fields["SUBJECTIVITY NUMBER.#{i}"] = i
      fields["SUBJECTIVITY.#{i}"] = s
    end

    pdftk.fill_form "app/views/layouts/quote_fairway.pdf", 'tmp/output.pdf', fields, flatten: true


    quote.update(status: 'issued', issue_date: Time.now)

    quote.quote_pdf = File.open('tmp/output.pdf')
    quote.save!

    DefaultMailer.send_quote_issued_email(@risk_profile, quote).deliver

    respond_to do |format|
      format.html { redirect_to @risk_profile, notice: 'Quote was successfully issued.' }
      format.js
    end

  end

  # GET /risk_profiles/1/view_quote/1
  def view_quote
    @quote = Quote.find(params[:quote_id])

    send_data @quote.quote_pdf.read.force_encoding('BINARY'), filename: (@quote.quote_pdf.path.split('/')[1]), disposition: 'inline', format: 'pdf', type:'application/pdf'
  end

  # PATCH /risk_profiles/1/update_rating/1
  def update_rating
    @rating = Rating.find(params[:rating_id])
    @rating.update(rating_params.delete_if { |key, value| value.blank? })
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

    def quote_params
      params.require(:quote).permit(:named_insured, :specialty, :broker_fee, :broker_commission,
      :effective, :retro, :policy_type, :deductible, :limit, :fairway_premium,
      :capital_contribution)
    end

    def rating_params
      params.require(:rating).permit(:capital, :physician_premium, :allied_premium,
      :nas_premium, :fairway_premium, :total_premium, :capital_contribution)
    end

    # A broker may only view his own risk profiles
    def broker_possession!
      if current_account.broker? && @risk_profile.broker_acct_id != @acct.id
        raise ActionController::RoutingError.new('Not Found (RiskProfilesController.rb:252)')
      end
    end

    def calculate_rating
      # Create a new rating (save all rates/factors at the time)
      capital_f     = 0.10 # Capital Rate is 10%

      nas_r         = !@risk_profile.limit_nas.blank? ? NasRate.where(limit: @risk_profile.limit_nas).first.rate : 0
      base_r        = (BaseRate.where(state: @risk_profile.state).first || BaseRate.offset(rand(BaseRate.count)).first).rate
      allied1_r     = AlliedRate.where(group: 'allied1').first.rate
      allied2_r     = AlliedRate.where(group: 'allied2').first.rate
      allied3_r     = AlliedRate.where(group: 'allied3').first.rate

      limit_f       = (LimitFactor.where(limit: @risk_profile.limit, state: @risk_profile.state).first || LimitFactor.offset(rand(LimitFactor.count)).first).factor
      deductible_f  = DedFactor.where(deductible: @risk_profile.deductible).first.factor
      step_f        = (StepFactor.where(policy_year: "1", state: @risk_profile.state).first || StepFactor.offset(rand(StepFactor.count)).first).factor

      risk          = RiskFactor.where(criteria: "CLAIMS FREE 3 TO 5 YEARS").first
      risk_f        = risk.min_factor
      risk_c        = risk.criteria

      entity_f      = EntityFactor.where(entity: @risk_profile.entity).first.factor
      entity_p      = 0

      specialty      = (SpecialtyFactor.where(spec_name: @risk_profile.specialty, state: @risk_profile.state).first || SpecialtyFactor.offset(rand(SpecialtyFactor.count)).first)
      specialty_f   = specialty.factor
      specialty_c   = specialty.spec_class

      territory     = (TerritoryFactor.where(territory: @risk_profile.territory, state: @risk_profile.state).first || TerritoryFactor.offset(rand(TerritoryFactor.count)).first)
      territory_n   = territory.number
      territory_e   = territory.exposure
      territory_f   = territory.factor

      physician_p   = (base_r * specialty_f * territory_f * deductible_f * step_f)
      allied_p      = (allied1_r * @risk_profile.allied1 + allied2_r * @risk_profile.allied2 + allied3_r * @risk_profile.allied3)
      fairway_p     = (((physician_p * risk_f * entity_f) + entity_p) * limit_f)
      capital_c     = (capital_f * fairway_p)

      #@risk_profile.ratings.create!(
      @rating = Rating.new(
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
          capital_factor:     capital_f,
          risk_factor:        risk_f,
          risk_criteria:      risk_c,
          territory_number:   territory_n,
          territory_exposure: territory_e,
          territory_factor:   territory_f
        },
        policy_year:          1,    # Start at first year (duh)
        capital:              true, # Always true before 3rd year
        physician_premium:    physician_p,
        allied_premium:       allied_p,
        nas_premium:          nas_r,
        fairway_premium:      fairway_p,
        total_premium:        (fairway_p + capital_c + nas_r),
        capital_contribution: capital_c,
        status_date:          Date.today
      )
    end
end
