class AddMetaToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :meta_id, :integer
    add_column :accounts, :meta_type, :string

    add_index :accounts, [:meta_id, :meta_type]
  end
end
