class CreateRiskFactors < ActiveRecord::Migration
  def change
    create_table :risk_factors do |t|
      t.string :criteria
      t.integer :max_debit
      t.integer :max_credit

      t.timestamps null: false
    end
  end
end
