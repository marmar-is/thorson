class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|

      t.integer :broker_fee
      t.decimal :broker_commision
      t.string :named_insured
      t.string :specialty
      t.date :effective
      t.date :retro
      t.integer :deductible
      t.string :limits
      t.string :addl_shared
      t.string :addl_separate
      t.string :excl_location
      t.string :excl_procedure
      #t.string :addl_employment
      #t.string :addl_electronic
      #t.string :addl_medefense
      #t.string :addl_sexual
      t.integer :fairway_premium
      t.integer :capital_contribution

      t.string :payment_type
      t.text :subjectivities, array: true, default: []

      t.text :policy_forms, array: true, default: []
      t.string :policy_type

      t.integer :status, default: 0
      t.datetime :status_date

      t.timestamps null: false
    end

    add_reference :quotes, :rating, index: true, foreign_key: true
    add_index  :quotes, :policy_forms, using: 'gin'
    add_index  :quotes, :subjectivities, using: 'gin'
  end
end
