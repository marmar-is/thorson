class Rating < ActiveRecord::Base
  # Associations
  belongs_to :risk_profile

  # Enumerations
  enum status: [:provisional, :determined]
    # provisional     -- actions have not yet been taken
    # determined      -- underwriter's decision to modify
end
