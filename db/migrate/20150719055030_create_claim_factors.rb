class CreateClaimFactors < ActiveRecord::Migration
  def change
    create_table :claim_factors do |t|
      t.integer :policy_year
      t.decimal :factor
      t.string :state

      t.timestamps null: false
    end
  end
end
