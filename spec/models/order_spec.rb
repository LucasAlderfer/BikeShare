require 'rails_helper'

describe Order do
  context 'Validations' do
    it {should validate_presence_of(:status)}
    it {should validate_presence_of(:user_id)}
  end
  context 'Relationships' do
    it {should belong_to(:user)}
    it {should have_many(:order_accessories)}
    it {should have_many(:accessories).through(:order_accessories)}
  end
  context 'Instance Methods' do
    it 'should give the total of all subtotals' do
      user = User.create(username: "asdf", password: "asdf")
      acc1 = Accessory.create(title: 'bike thing', description: 'does things', price: 2, status: 'Active', image: 'pic.jpg')
      acc2 = Accessory.create(title: 'other thing', description: 'does others', price: 4, status: 'Active', image: 'img.jpg')
      order_1 = user.orders.create(status: 2)
      order_1.order_accessories.create(quantity: 2, accessory_id: acc1.id)
      order_1.order_accessories.create(quantity: 1, accessory_id: acc2.id)

      expected = 8

      expect(order_1.total).to eq(expected)
    end
  end
  context 'Class Methods' do
    it 'should give counts of orders by status' do
      user = User.create(username: "asdf", password: "asdf")
      order_1 = user.orders.create(status: 0)
      order_2 = user.orders.create(status: 0)
      order_3 = user.orders.create(status: 1)
      order_4 = user.orders.create(status: 2)
      order_5 = user.orders.create(status: 2)
      order_6 = user.orders.create(status: 2)
      order_7 = user.orders.create(status: 3)
      order_8 = user.orders.create(status: 3)

      expect(Order.cnt_ordered).to eq(2)
      expect(Order.cnt_completed).to eq(1)
      expect(Order.cnt_paid).to eq(3)
      expect(Order.cnt_cancelled).to eq(2)
    end
  end
end
