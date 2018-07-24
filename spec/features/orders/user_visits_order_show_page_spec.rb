require 'rails_helper'

describe 'User visits order show page' do
  it 'sees individual order show info' do
    user = User.create(username: "asdf", password: "asdf")
    order_1 = user.orders.create(status: 2)
    order_2 = user.orders.create(status: 3)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(page).to have_content(order_1.id)
    expect(page).to have_content(order_2.id)

    click_on("Order #{order_1.id} - #{order_1.status}")

    expect(current_path).to eq(user_order_path(user, order_1))
    expect(page).to have_content(order_1.status)
    expect(page).to_not have_content(order_2.status)
  end
end
