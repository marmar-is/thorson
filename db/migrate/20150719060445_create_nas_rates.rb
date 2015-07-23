class CreateNasRates < ActiveRecord::Migration
  def change
    create_table :nas_rates do |t|
      t.integer :limit
      t.integer :rate

      t.timestamps null: false
    end
  end
end
