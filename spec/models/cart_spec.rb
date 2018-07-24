require 'rails_helper'

describe Cart do
  describe 'instance methods' do
    before :each do
      @cart = Cart.new({'1' => 2, '2' => 3})
    end
    it '.total_count' do
      expect(@cart.total_count).to eq(5)
    end
    it '.add_accessory' do
      @cart.add_accessory(1)
      @cart.add_accessory(2)

      expect(@cart.contents).to eq({'1' => 3, '2' => 4})
    end
  end
end
