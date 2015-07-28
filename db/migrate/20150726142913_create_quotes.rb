class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|

      t.integer :broker_fee
      t.decimal :broker_commision

      t.string :named_insured
      t.string :specialty
      t.date :effective
      t.date :retro

      t.text :addl_shared, array: true, default: []
      t.text :addl_separate, array: true, default: []

      t.boolean :addtl_employment
      t.boolean :addtl_electronic
      t.boolean :addtl_medefense
      t.boolean :addtl_sexual

      t.text :excl_locations, array: true, default: []
      t.text :excl_procedures, array: true, default: []

      t.string :policy_type
      t.text :policy_forms, array: true, default: []

      t.text :subjectivities, array: true, default: []

      t.integer :deductible
      t.string :limits

      t.integer :fairway_premium
      t.integer :capital_contribution

      t.string :payment_type

      t.integer :status, default: 0
      t.datetime :status_date

      t.timestamps null: false
    end

    add_reference :quotes, :rating, index: true, foreign_key: true
    add_index  :quotes, :policy_forms, using: 'gin'
    add_index  :quotes, :subjectivities, using: 'gin'
    #add_index  :quotes, :addl_shared, using: 'gin'
    #add_index  :quotes, :addl_separate, using: 'gin'
    #add_index  :quotes, :excl_locations, using: 'gin'
    #add_index  :quotes, :excl_procedures, using: 'gin'
  end
end
