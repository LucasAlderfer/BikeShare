require 'rails_helper'

describe 'as a reigistered user checking out' do
  it 'can add things to cart and checkout' do
    user = User.create(username: 'jorj', password: 'password')
    first_name = 'Jorj'
    last_name = 'Castanza'
    street = '123 Main St'
    city = 'Denver'
    state = 'CO'
    zip = 12345

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    part_1 = Accessory.create(title: 'thing1', description: 'kjhs', price: 4, status: 0, image: 'http://placekitten/200/200')
    part_2 = Accessory.create(title: 'thing2', description: 'kjhgt6s', price: 6, status: 0, image: 'http://placekitten/200/200')
    total = 10

    visit '/bike-shop'

    within "#accessory-#{part_1.id}" do
      click_on 'Add to Cart'
    end

    within "#accessory-#{part_2.id}" do
      click_on 'Add to Cart'
    end

    visit cart_path
    expect(page).to have_content('Cart Count: 2')
    #we've already tested that all info is present on this page so no need to test again
    click_button 'Checkout'

    expect(current_path).to eq(new_user_order_path(user))

    fill_in :order_first_name, with: first_name
    fill_in :order_last_name, with: last_name
    fill_in :order_street, with: street
    fill_in :order_city, with: city
    fill_in :order_state, with: state
    fill_in :order_zip, with: zip
    click_on 'Create Order'

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content("Successfully submitted your order totaling $#{total}")
    expect(page).to have_content('Cart Count: 0')
    #TODO need to add conditional on dashboard page about only listing orders if there are any to list
  end
end
