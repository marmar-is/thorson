class DefaultMailer < ApplicationMailer
  default from: 'no-reply@thorsongroup.com'

  # Send a new risk profile email to all employees
  def send_new_risk_email(risk, delivery_group)
    @risk = risk
    @broker = risk.broker_acct

    headers['X-SMTPAPI'] = {
      category: 'Risk Notification',
      to: delivery_group # this should be 1
    }.to_json

    mail( to: "risk@thorsongroup.com", subject: 'A new Risk has been filed' )
  end

  # Send an email describing a risk profile's status update to its broker
  def send_risk_status_update_email(risk)
    @risk = risk
    @broker = risk.broker_acct

    headers['X-SMTPAPI'] = {
      category: 'Risk Status Update',
    }.to_json

    mail( to: @broker.email, subject: 'One of your risks has been updated' )
  end
end
