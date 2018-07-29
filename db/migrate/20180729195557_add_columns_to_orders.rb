class AddColumnsToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :first_name, :string
    add_column :orders, :last_name, :string
    add_column :orders, :street, :string
    add_column :orders, :city, :string
    add_column :orders, :state, :string
    add_column :orders, :zip, :integer
  end
end
