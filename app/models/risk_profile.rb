class RiskProfile < ActiveRecord::Base
  # Validations
  validates :name, presence: true
  validates :county, presence: true
  validates :state, presence: true
  validates :effective, presence: true
  #validates :retro, presence: true
  validates :specialty, presence: true
  validates :deductible, presence: true
  validates :limits, presence: true
  validates :limit_nas, presence: true
  validates :entity, presence: true
  validates :allied1, presence: true
  validates :allied2, presence: true
  validates :allied3, presence: true
  validates :sub_specialty, presence: true

end
