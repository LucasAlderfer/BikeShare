class Order < ApplicationRecord

  validates_presence_of :status, :created_at, :updated_at, :user_id

  belongs_to :user
  has_many :order_accessories
  has_many :accessories, through: :order_accessories
end
