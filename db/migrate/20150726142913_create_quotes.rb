class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.integer :broker_fee
      t.decimal :broker_commision
      t.datetime :quote_issued
      t.string :named_insured
      t.string :specialty
      t.string :effective
      t.string :retro
      t.string :deductible
      t.string :policy_form
      t.string :limits
      t.string :addl_shared
      t.string :addl_separate
      t.string :exclusions_location
      t.string :exclusions_procedure
      t.string :additional_employment
      t.string :additional_electronic
      t.string :additional_medefense
      t.string :additional_sexual
      t.string :premium_fairway
      t.string :capital_contribution

      t.timestamps null: false
    end

    add_reference :quotes, :rating, index: true, foreign_key: true
  end
end
