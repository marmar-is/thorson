class CreateTerritoryFactors < ActiveRecord::Migration
  def change
    create_table :territory_factors do |t|
      t.decimal :factor
      t.string :territory
      t.integer :number
      t.decimal :exposure
      t.string :state

      t.timestamps null: false
    end
  end
end
