class CreateRiskProfiles < ActiveRecord::Migration
  def change
    create_table :risk_profiles do |t|
      t.string :name
      t.string :territory
      t.string :state
      t.string :territory
      t.date :effective
      t.date :retro
      t.string :specialty
      t.string :specialty_surgery
      t.integer :deductible
      t.string :limit
      t.string :limit_nas
      t.boolean :entity
      t.integer :allied1
      t.integer :allied2
      t.integer :allied3
      t.string :sub_specialty
      t.boolean :capital
      t.string :license

      t.timestamps null: false
    end

    add_reference :risk_profiles, :broker_acct, index: true, foreign_key: true
  end
end

=begin
, default: ""
, default: ""
, default: ""
, default: ""
, default: "11/08/1995"
, default: nil
, default: ""
, default: 0
, default: ""
, default: ""
, default: false
, default: 0
, default: 0
, default: 0
, default: ""
=end
