require 'rails_helper'

describe 'User visits order show page' do
  it 'sees individual order show info' do
    user = User.create(username: "asdf", password: "asdf")
    order_1 = user.orders.create(status: "Paid")
    order_2 = user.orders.create(status: "Cancelled")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(page).to have_content(order_1.id)

    #no idea why I chose status here, orders don't have a title and it seemed weird to click on an id, feel free to change it to whatever you want
    click_on(order_1.status)

    expect(current_path).to eq(order_path(order_1))
    expect(page).to have_content(order_1.status)
    expect(page).to_not have_content(order_2.status)
  end
end
