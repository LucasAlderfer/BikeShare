require 'rails_helper'

describe Cart do
  describe 'instance methods' do
    before :each do
      # @cart = Cart.new({'1' => 2, '2' => 3})
    end
    it '.total_count' do
      @cart = Cart.new({'1' => 2, '2' => 3})
      expect(@cart.total_count).to eq(5)
    end
    it '.add_accessory' do
      @cart = Cart.new({'1' => 2, '2' => 3})
      @cart.add_accessory(1)
      @cart.add_accessory(2)

      expect(@cart.contents).to eq({'1' => 3, '2' => 4})
    end
    it '.accessory_quantity' do
      part_1 = Accessory.create(title: 'thing1', description: 'kjhs', price: 4, status: 0, image: 'hjtkhtjk')
      @cart = Cart.new({})
      @cart.add_accessory(part_1.id)
      @cart.add_accessory(part_1.id)

      quantity = 2

      expect(@cart.accessory_quantity(part_1.id)).to eq(quantity)
    end
    it '.subtotal' do
      part_1 = Accessory.create(title: 'thing1', description: 'kjhs', price: 4, status: 0, image: 'hjtkhtjk')
      @cart = Cart.new({})
      @cart.add_accessory(part_1.id)
      @cart.add_accessory(part_1.id)

      expected = 8

      expect(@cart.subtotal(part_1.id)).to eq(expected)
    end
    it '.total' do
      part_1 = Accessory.create(title: 'thing1', description: 'kjhs', price: 4, status: 0, image: 'hjtkhtjk')
      part_2 = Accessory.create(title: 'thing2', description: 'kjhgt6s', price: 6, status: 0, image: 'IIIII')
      @cart = Cart.new({})
      @cart.add_accessory(part_1.id)
      @cart.add_accessory(part_2.id)

      expected = 10

      expect(@cart.total).to eq(expected)
    end
    it '.accessory_ids' do
      part_1 = Accessory.create(title: 'thing1', description: 'kjhs', price: 4, status: 0, image: 'hjtkhtjk')
      part_2 = Accessory.create(title: 'thing2', description: 'kjhgt6s', price: 6, status: 0, image: 'IIIII')
      @cart = Cart.new({})
      @cart.add_accessory(part_1.id)
      @cart.add_accessory(part_2.id)

      expected = [1, 2]

      expect(@cart.accessory_ids).to eq(expected)
    end
  end
end
