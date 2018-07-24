class Order < ApplicationRecord

  validates_presence_of :status, :user_id

  belongs_to :user
  has_many :order_accessories
  has_many :accessories, through: :order_accessories

  enum status: ['ordered', 'completed', 'paid', 'cancelled']

  def total #TODO refactor!
    tot = []
    order_accessories.each do |ord_acc|
      tot << ord_acc.subtotal
    end
    tot.sum
  end

end
