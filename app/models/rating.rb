class Rating < ActiveRecord::Base
  # Associations
  belongs_to :risk_profile

  # Enumerations
  enum status: [:provisional, :determined]
end
