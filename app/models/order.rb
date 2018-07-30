class Order < ApplicationRecord

  validates_presence_of :status, :user_id

  belongs_to :user
  has_many :order_accessories
  has_many :accessories, through: :order_accessories

  enum status: ['ordered', 'completed', 'paid', 'cancelled']

  def total
    order_accessories.joins(:accessory)
                     .sum('quantity * price')
  end

end
