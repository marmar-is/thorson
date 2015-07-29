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
end
