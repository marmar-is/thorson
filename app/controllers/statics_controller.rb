class StaticsController < ApplicationController
  layout false, only: [ :portal ]

  def index
    if current_account.admin?
      render :index

    elsif current_account.broker?

      if current_account.broker_acct.nil?
        redirect_to new_broker_acct_path
      else
        redirect_to new_risk_profile_path
      end

    elsif current_account.employee?
      redirect_to factors_path
    else
      raise AbstractController::ActionNotFound
    end

  end

  def portal
  end

end
