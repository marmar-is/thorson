class CreateStepFactors < ActiveRecord::Migration
  def change
    create_table :step_factors do |t|
      t.string :policy_year
      t.decimal :factor
      t.string :state

      t.timestamps null: false
    end
  end
end
