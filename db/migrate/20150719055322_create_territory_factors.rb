class CreateTerritoryFactors < ActiveRecord::Migration
  def change
    create_table :territory_factors do |t|
      t.decimal :factor
      t.string :county
      t.string :state

      t.timestamps null: false
    end
  end
end
