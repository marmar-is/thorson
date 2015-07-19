class CreateStateRates < ActiveRecord::Migration
  def change
    create_table :state_rates do |t|
      t.string :state
      t.integer :rate

      t.timestamps null: false
    end
  end
end
