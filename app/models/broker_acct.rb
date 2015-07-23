class BrokerAcct < ActiveRecord::Base
  # Associations
  has_one :account, as: :meta, dependent: :destroy
  has_many :risk_profiles

end
