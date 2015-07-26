class DefaultMailer < ApplicationMailer
  default from: 'no-reply@thorsongroup.com'

  # send a signup email to the user, pass in the user object that contains the user's email address
  def send_new_risk_email(risk)
    @risk = risk
    @broker = risk.broker_acct

    headers['X-SMTPAPI'] = {
      category: 'Risk Notification',
      to: Account.where(role: 2).pluck(:email) # this should be 1
    }.to_json

    mail( to: "risk@thorsongroup.com", subject: 'A new Risk has been filed' )
  end
end
