class Order < ApplicationRecord

  validates_presence_of :status, :user_id, :first_name, :last_name, :street, :city, :state, :zip

  belongs_to :user
  has_many :order_accessories
  has_many :accessories, through: :order_accessories

  enum status: ['ordered', 'completed', 'paid', 'cancelled']

  def total
    order_accessories.joins(:accessory)
                     .sum('quantity * price')
  end

  def self.cnt_ordered
    where(status: 0).count
  end

  def self.cnt_completed
    where(status: 1).count
  end
  def self.cnt_paid
    where(status: 2).count
  end
  def self.cnt_cancelled
    where(status: 3).count
  end




end
