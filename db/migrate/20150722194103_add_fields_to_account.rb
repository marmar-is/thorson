class AddFieldsToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :role, :string, default: "error"
    add_column :accounts, :fname, :string
    add_column :accounts, :lname, :string
  end
end
