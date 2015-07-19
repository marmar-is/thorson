class CreateLimitFactors < ActiveRecord::Migration
  def change
    create_table :limit_factors do |t|
      t.decimal :factor
      t.string :limit
      t.string :state

      t.timestamps null: false
    end
  end
end
