class RiskProfile < ActiveRecord::Base
  # Associations
  belongs_to :broker_acct
  has_many :ratings, dependent: :destroy

  # Validations
  validates :name, presence: true
  validates :territory, presence: true
  validates :state, presence: true
  validates :effective, presence: true
  #validates :retro, presence: true
  validates :specialty, presence: true
  validates :deductible, presence: true
  validates :limit, presence: true
  #validates :limit_nas, presence: true
  #validates :entity, presence: true
  validates :allied1, presence: true
  validates :allied2, presence: true
  validates :allied3, presence: true
  #validates :sub_specialty, presence: true

  # Enumerations
  enum status: [:submitted, :accepted, :declined, :withdrawn]
    # pending       -- actions have not yet been taken
    # accepted      -- underwriter's decision to accept the risk
    # declined      -- underwriter's decision to decline the risk
    # withdrawn     -- broker's decision to withdraw the risk

  # Order
  default_scope { order('id ASC') }
end
