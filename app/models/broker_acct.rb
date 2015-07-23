class BrokerAcct < ActiveRecord::Base
  # Associations
  has_one :account
  has_many :risk_profiles
end
