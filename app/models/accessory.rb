class Accessory < ApplicationRecord
  validates_presence_of :description, :status, :image
  validates :title, uniqueness: true, presence: true
  validates :price, numericality: {greater_than:0}, presence: true

  enum status: ['Active', 'Retired']

  has_many :order_accessories
  has_many :orders, through: :order_accessories
end
