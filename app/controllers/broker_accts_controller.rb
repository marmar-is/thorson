class BrokerAcctsController < ApplicationController
  #before_action :set_broker_acct, only: [:show, :edit, :update, :destroy]

  # GET /broker_accts/new
  def new
    @broker_acct = BrokerAcct.new
  end

  # POST /broker_accts
  # POST /broker_accts.json
  def create
    @broker_acct = BrokerAcct.new(broker_acct_params)
    @broker_acct.account = current_account

    respond_to do |format|
      if @broker_acct.save
        format.html { redirect_to new_risk_profile_path, notice: 'Risk profile was successfully created.' }
        #format.json { render :show, status: :created, location: @broker_acct }
      else
        format.html { render :new }
        #format.json { render json: @broker_acct.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_broker_acct
    @broker_acct = current_account.broker_acct
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def broker_acct_params
    params.require(:broker_acct).permit(:name, :code, :contact_name, :email, :phone, :street, :city, :state, :zip)
  end
end
