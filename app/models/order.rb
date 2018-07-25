class Order < ApplicationRecord

  validates_presence_of :status, :user_id

  belongs_to :user
  has_many :order_accessories
  has_many :accessories, through: :order_accessories

  enum status: ['ordered', 'completed', 'paid', 'cancelled']

  def total #TODO refactor!
    order_accessories.inject(0) do |sum, ord_acc|
      sum + ord_acc.subtotal
    end
  end

end
