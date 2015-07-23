class CreateBaseRates < ActiveRecord::Migration
  def change
    create_table :base_rates do |t|
      t.integer :rate
      t.string :state

      t.timestamps null: false
    end
  end
end
