class CreateAlliedRates < ActiveRecord::Migration
  def change
    create_table :allied_rates do |t|
      t.integer :rate
      t.string :state
      t.string :category
      t.text :elements, array: true, default: []

      t.timestamps null: false
    end

    add_index  :allied_rates, :elements, using: 'gin'
  end
end
