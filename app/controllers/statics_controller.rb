class StaticsController < ApplicationController
  layout false, only: [ :portal ]

  def index
    if current_account.admin?
      render :index
    elsif current_account.broker?
        redirect_to risk_profiles_path
    elsif current_account.employee?
      redirect_to factors_path
    else
      raise AbstractController::ActionNotFound
    end

  end

  def portal
  end

end
