class Accessory < ApplicationRecord
  validates_presence_of :title, :description, :price, :status, :image

  has_many :order_accessories
  has_many :orders, through: :order_accessories
end
