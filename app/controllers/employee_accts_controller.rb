class EmployeeAcctsController < ApplicationController
  before_action :employee_access!
  #before_action :set_employee_acct, only: [ :profile, :update ]
  skip_before_action :authenticate_meta!, only: [ :new, :create ]

  # GET /employee_accts/new
  def new
    @acct = EmployeeAcct.new
  end

  # POST /employee_accts
  # POST /employee_accts.json
  def create
    @acct = EmployeeAcct.new(employee_acct_params)
    @acct.account = current_account

    respond_to do |format|
      if @acct.save
        format.html { redirect_to "/", notice: 'Employee Account was successfully created.' }
        format.json { redirect_to "/", status: :created, location: @acct }
      else
        format.html { render :new }
        format.json { render json: @acct.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employee_accts/1
  def update
    respond_to do |format|
      if @acct.update(employee_acct_params)
        format.html { render :profile, notice: 'Employee was successfully updated.' }
        format.json { render :profile, status: :ok, location: @acct }
      else
        format.html { render :profile }
        format.json { render json: @acct.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /profile
  def profile
  end

  protected
  def employee_access!
    if account_signed_in? && !current_account.employee? && !current_account.admin?
      begin
        redirect_to :back, notice: 'You are attempting to access an employee-only zone.'
      rescue
        redirect_to "/", notice: 'You are attempting to access an employee-only zone.'
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_employee_acct
    #@employee_acct = current_account.meta
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def employee_acct_params
    params.require(:employee_acct).permit(:role)
  end
end
