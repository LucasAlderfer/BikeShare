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
end
