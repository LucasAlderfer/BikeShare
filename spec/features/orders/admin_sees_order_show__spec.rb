require 'rails_helper'

describe 'admin sees individual order show page' do
  xit 'sees order thingies, including purchaser and item info' do
    user1 = User.create(username: 'bob', password: '12345')
    user2 = User.create(username: 'fred', password: '54321')
    acc1 = Accessory.create(title: 'bike thing', description: 'does things', price: 2, status: 'Active', image: 'pic.jpg')
    acc2 = Accessory.create(title: 'other thing', description: 'does others', price: 4, status: 'Active', image: 'img.jpg')
    order_1 = user1.orders.create(status: 1)
    order_2 = user2.orders.create(status: 3)
    order_1.order_accessories.create(quantity: 2, accessory_id: acc1.id)
    order_2.order_accessories.create(quantity: 1, accessory_id: acc2.id)

    admin = User.create(username: 'dave', password: '98765', role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit order_path(order_1)



  end
end
