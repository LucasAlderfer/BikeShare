require 'rails_helper'

describe OrderAccessories do
  describe 'validations' do
    it {should validate_presence_of(:order_id)}
    it {should validate_presence_of(:accessory_id)}
    it {should validate_presence_of(:quantity)}
  end
  describe 'Relationships' do
    it {should belong_to(:orders)}
    it {should belong_to(:accessories)}
  end
end
