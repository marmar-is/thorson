class CreateDedFactors < ActiveRecord::Migration
  def change
    create_table :ded_factors do |t|
      t.integer :deductible
      t.decimal :factor
      t.string :state

      t.timestamps null: false
    end
  end
end
