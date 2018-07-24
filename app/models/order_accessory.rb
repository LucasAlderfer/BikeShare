class OrderAccessory < ApplicationRecord

  validates_presence_of :quantity, :order_id, :accessory_id

  belongs_to :order
  belongs_to :accessory

  def subtotal
    quantity * accessory.price
  end

end
