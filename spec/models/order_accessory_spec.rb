require 'rails_helper'

describe OrderAccessory do
  describe 'validations' do
    it {should validate_presence_of(:order_id)}
    it {should validate_presence_of(:accessory_id)}
    it {should validate_presence_of(:quantity)}
  end
  describe 'Relationships' do
    it {should belong_to(:order)}
    it {should belong_to(:accessory)}
  end
  describe 'instance methods' do
    it 'should give the subtotal of the order_accessory' do
      user = User.create(username: "asdf", password: "asdf")
      acc1 = Accessory.create(title: 'bike thing', description: 'does things', price: 2, status: 'Active', image: 'pic.jpg')
      order_1 = user.orders.create(status: 1, first_name: "adsf", last_name: "asdf", street: "asdflkj", city: "dfljk", state: "CO", zip: 37364)
      ord_acc = order_1.order_accessories.create(quantity: 2, accessory_id: acc1.id)

      expected = 4

      expect(ord_acc.subtotal).to eq(expected)
    end
  end
end
