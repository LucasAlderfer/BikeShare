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
end
