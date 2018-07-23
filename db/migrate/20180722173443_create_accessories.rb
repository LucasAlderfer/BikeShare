class CreateAccessories < ActiveRecord::Migration[5.1]
  def change
    create_table :accessories do |t|
      t.string :title
      t.string :description
      t.integer :price
      t.integer :status
      t.string :image
    end
  end
end
