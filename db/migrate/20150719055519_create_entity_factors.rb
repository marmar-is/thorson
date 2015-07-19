class CreateEntityFactors < ActiveRecord::Migration
  def change
    create_table :entity_factors do |t|
      t.decimal :factor, default: 0
      t.string :name_exposure, default:""

      t.timestamps null: false
    end
  end
end
