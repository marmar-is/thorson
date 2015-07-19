class CreateRiskProfiles < ActiveRecord::Migration
  def change
    create_table :risk_profiles do |t|
      t.string :name, default: ""
      t.string :county, default: ""
      t.string :state, default: ""
      t.date :effective, default: "1995-11-08"
      t.date :retro, default: nil
      t.string :specialty, default: ""
      t.integer :deductible, default: 0
      t.string :limits, default: ""
      t.string :limit_nas, default: ""
      t.boolean :entity, default: false
      t.integer :allied1, default: 0
      t.integer :allied2, default: 0
      t.integer :allied3, default: 0
      t.string :sub_specialty, default: ""

      t.timestamps null: false
    end
  end
end
