class Rating < ActiveRecord::Base
  # Associations
  belongs_to :risk_profile
  has_many :quotes

  # Enumerations
  enum status: [:provisional, :determined]
    # provisional     -- actions have not yet been taken
    # determined      -- underwriter's decision to modify

  # Order
  default_scope { order('id ASC') }

  def risk_factor
    sum = 0
    self.risk_factors.each do |rf|
      sum += rf[1].to_d
    end
    return (sum / self.risk_factors.count)
  end
end
