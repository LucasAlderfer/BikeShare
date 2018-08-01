require 'rails_helper'

describe 'User visits order show page' do
  it 'sees individual order show info' do
    user = User.create(username: "asdf", password: "asdf")
    acc1 = Accessory.create(title: 'bike thing', description: 'does things', price: 2, status: 'Active', image: 'pic.jpg')
    acc2 = Accessory.create(title: 'other thing', description: 'does others', price: 4, status: 'Active', image: 'img.jpg')
    order_1 = user.orders.create(status: 1, first_name: "adsf", last_name: "asdf", street: "asdflkj", city: "dfljk", state: "CO", zip: 37364)
    order_2 = user.orders.create(status: 3, first_name: "adsf", last_name: "asdf", street: "asdflkj", city: "dfljk", state: "CO", zip: 37364)

    order_1.order_accessories.create(quantity: 2, accessory_id: acc1.id)
    order_1.order_accessories.create(quantity: 1, accessory_id: acc2.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(page).to have_content(order_1.id)
    expect(page).to have_content(order_2.id)

    click_on("Order #{order_1.id} - #{order_1.status}")

    expect(current_path).to eq(user_order_path(user, order_1))
    expect(page).to have_content(order_1.status)
    expect(page).to_not have_content(order_2.status)
    expect(page).to have_content(acc1.title)
    expect(page).to have_content('Quantity: 2')
    expect(page).to have_content('Subtotal: $4.00')
    expect(page).to have_content(acc2.title)
    expect(page).to have_content('Quantity: 1')
    expect(page).to have_content('Subtotal: $4.00')
    expect(page).to have_content('Total: $8.00')
    expect(page).to have_content("Submitted: #{order_1.created_at}")
    expect(page).to have_content("Status updated: #{order_1.updated_at}")
  end
end
