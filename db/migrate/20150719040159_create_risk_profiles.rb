class CreateRiskProfiles < ActiveRecord::Migration
  def change
    create_table :risk_profiles do |t|
      t.string :name
      t.string :state
      t.string :territory
      t.date :effective
      t.date :retro
      t.string :specialty
      t.string :specialty_surgery
      t.integer :deductible
      t.string :limit
      t.string :limit_nas
      t.string :addl_shared
      t.string :addl_separate
      t.boolean :entity
      t.integer :allied1
      t.integer :allied2
      t.integer :allied3
      t.string :sub_specialty
      t.boolean :capital
      t.string :license

      t.integer :status, default: 0
      t.datetime :status_date

      t.timestamps null: false
    end

    add_reference :risk_profiles, :broker_acct, index: true, foreign_key: true
  end
end
