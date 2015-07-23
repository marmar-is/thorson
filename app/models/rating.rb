class Rating < ActiveRecord::Base
  # Associations
  belongs_to :risk_profile
end
