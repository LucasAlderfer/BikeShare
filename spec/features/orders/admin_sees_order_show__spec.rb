require 'rails_helper'

describe 'admin sees individual order show page' do
  it 'sees order thingies, including purchaser and item info' do
    user1 = User.create(username: 'bob', password: '12345')
    user2 = User.create(username: 'fred', password: '54321')
    acc1 = Accessory.create(title: 'bike thing', description: 'does things', price: 2, status: 'Active', image: 'pic.jpg')
    acc2 = Accessory.create(title: 'other thing', description: 'does others', price: 4, status: 'Active', image: 'img.jpg')
    order_1 = user1.orders.create(status: 1, first_name: 'Bob', last_name: 'Jones', street: '123 Main St', city: 'Denver', state: 'CO', zip: 12345)
    order_2 = user2.orders.create(status: 3, first_name: 'Fred', last_name: 'Smith', street: '567 Main St', city: 'Denver', state: 'CO', zip: 54321)
    order_acc1 = order_1.order_accessories.create(quantity: 2, accessory_id: acc1.id)
    order_acc2 = order_2.order_accessories.create(quantity: 1, accessory_id: acc2.id)

    admin = User.create(username: 'dave', password: '98765', role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit user_order_path(user1, order_1)

    expect(page).to have_content("Submitted: #{order_1.created_at}")
    expect(page).to have_content("Name: #{order_1.first_name} #{order_1.last_name}")
    expect(page).to have_content("Street Address: #{order_1.street}")
    expect(page).to have_content("City/State/Zip: #{order_1.city}, #{order_1.state} #{order_1.zip}")

    expect(page).to have_selector(order_acc1.accessory.title)
    expect(page).to have_content(order_acc1.quantity)
    expect(page).to have_content(order_acc1.subtotal)
    expect(page).to have_content(order_1.total)
    expect(page).to have_content(order_1.status)
  end
end
