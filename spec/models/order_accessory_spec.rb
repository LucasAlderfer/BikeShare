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
end
