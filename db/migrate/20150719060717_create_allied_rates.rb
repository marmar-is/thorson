class CreateAlliedRates < ActiveRecord::Migration
  def change
    create_table :allied_rates do |t|
      t.integer :rate
      t.string :group
      t.text :constituents, array: true, default: []

      t.timestamps null: false
    end

    add_index  :allied_rates, :constituents, using: 'gin'
  end
end
