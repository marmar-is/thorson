class AddFieldsToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :role, :string, default: "error"
    add_column :accounts, :fname, :string, default: ""
    add_column :accounts, :lname, :string, default: ""
  end
end
