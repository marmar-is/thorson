class CreateRiskFactors < ActiveRecord::Migration
  def change
    create_table :risk_factors do |t|
      t.string :criteria
      t.decimal :min_factor
      t.decimal :max_factor

      t.timestamps null: false
    end
  end
end
