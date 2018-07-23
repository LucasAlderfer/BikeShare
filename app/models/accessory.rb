class Accessory < ApplicationRecord
  validates_presence_of :title, :description, :price, :status, :image
end
