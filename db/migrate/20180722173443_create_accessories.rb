class CreateAccessories < ActiveRecord::Migration[5.1]
  def change
    create_table :accessories do |t|
      t.string :title
      t.string :description
      t.decimal :price
      t.integer :status, default: 0
      t.string :image
    end
  end
end
