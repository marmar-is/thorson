class CreateRatings < ActiveRecord::Migration
  def change
    enable_extension "hstore" # enable hstore datatype

    create_table :ratings do |t|

      t.hstore :risk_prof # taken directly from risk profile

      t.hstore :rates # taken directly from current rates
      t.hstore :factors # taken directly from current factors
      t.hstore :risk_factors#, array: true, default: []

      t.integer :policy_year
      t.boolean :capital

      t.decimal :physician_premium, default: 0
      t.decimal :allied_premium, default: 0
      t.decimal :nas_premium, default: 0
      t.decimal :fairway_premium, default: 0
      t.decimal :total_premium, default: 0
      t.integer :capital_contribution, default: 0

      t.integer :status, default: 0
      t.datetime :status_date

      t.timestamps null: false
    end

    add_reference :ratings, :risk_profile, index: true, foreign_key: true
    #add_index  :ratings, :risk_factors, using: 'gin'
  end
end
