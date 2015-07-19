class CreateDedFactors < ActiveRecord::Migration
  def change
    create_table :ded_factors do |t|
      t.integer :amount, default: 0
      t.decimal :factor, default: 0
      t.string :state, default: "CA"

      t.timestamps null: false
    end
  end
end
