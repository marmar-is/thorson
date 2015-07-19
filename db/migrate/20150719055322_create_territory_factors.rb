class CreateTerritoryFactors < ActiveRecord::Migration
  def change
    create_table :territory_factors do |t|
      t.decimal :factor, default: 0
      t.string :county, default: "Los Angeles"

      t.timestamps null: false
    end
  end
end
