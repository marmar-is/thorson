class CreateSpecialties < ActiveRecord::Migration
  def change
    create_table :specialties do |t|
      t.string :name, default: ""
      t.decimal :factor, default: 0

      t.timestamps null: false
    end
  end
end
