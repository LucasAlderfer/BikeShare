require 'rails_helper'

describe Accessory do
  describe 'validations' do
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:price)}
    it {should validate_presence_of(:status)}
    it {should validate_presence_of(:image)}
  end
  describe 'relationships' do
    #TODO
    it {should have_many(:order_accessories)}
    it {should have_many(:orders).through(:order_accessories)}
  end
  describe 'default status' do
    it 'should default to a status of 0' do
      accessory = Accessory.create(title: "asdf", description: "sdfjkhdsf", image: "asdf", price: 4)

      expect(accessory).to be_valid
    end
  end
  describe 'uniqueness of title' do
    it 'has a unique title' do
      product_1 = Accessory.create(title: "asdf", price: 23, status: 0, description: "jkhfs", image: "http://placekitten.com/200/200")
      product_2 = Accessory.create(title: "asdf", price: 23, status: 0, description: "jkhfs", image: "http://placekitten.com/200/200")

      expect(product_2).to_not be_valid
    end
  end
  describe "price can't be negative" do
    it 'cannot have negative price' do
      product_1 = Accessory.create(title: "asdf", price: -23, status: 0, description: "jkhfs", image: "http://placekitten.com/200/200")

      expect(product_1).to_not be_valid
    end
  end
end
