class CreateEmployeeAccts < ActiveRecord::Migration
  def change
    create_table :employee_accts do |t|
      t.integer :role, default: 0

      t.timestamps null: false
    end
  end
end
