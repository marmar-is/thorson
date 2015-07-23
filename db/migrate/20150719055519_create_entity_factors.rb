class CreateEntityFactors < ActiveRecord::Migration
  def change
    create_table :entity_factors do |t|
      t.decimal :factor
      t.boolean :entity

      t.timestamps null: false
    end
  end
end
