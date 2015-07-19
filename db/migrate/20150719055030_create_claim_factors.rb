class CreateClaimFactors < ActiveRecord::Migration
  def change
    create_table :claim_factors do |t|
      t.integer :year, default:0
      t.decimal :factor, default:0
      t.string :state, default: "CA"

      t.timestamps null: false
    end
  end
end
