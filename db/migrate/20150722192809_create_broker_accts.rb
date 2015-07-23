class CreateBrokerAccts < ActiveRecord::Migration
  def change
    create_table :broker_accts do |t|
      t.string :name, default: ""
      t.string :code, default: ""

      t.string :contact_name, default: ""
      t.string :email, default: ""
      t.string :phone, default: ""

      t.string :street, default: ""
      t.string :city, default: ""
      t.string :state, default: ""
      t.string :zip, default: ""

      t.timestamps null: false
    end
    add_index :broker_accts, :code, unique: true
  end
end
