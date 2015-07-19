class CreateEntityFactors < ActiveRecord::Migration
  def change
    create_table :entity_factors do |t|
      t.decimal :factor
      t.string :entity
      t.string :state

      t.timestamps null: false
    end
  end
end
