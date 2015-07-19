class CreateSpecialtyFactors < ActiveRecord::Migration
  def change
    create_table :specialty_factors do |t|
      t.string :spec_name
      t.decimal :factor
      t.string :state

      t.timestamps null: false
    end
  end
end
