class AddFieldsToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :role, :integer, default: 0
    add_column :accounts, :fname, :string, default: ""
    add_column :accounts, :lname, :string, default: ""

    #add_reference :accounts, :broker_acct, index: true, foreign_key: true
    #add_reference :accounts, :employee_acct, index:true, foreign_key: true
  end
end
