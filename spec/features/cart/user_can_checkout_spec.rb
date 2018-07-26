require 'rails_helper'

describe 'when checking out' do
  it 'can add things to cart and checkout' do
    user = User.create(username: 'jorj', password: 'password')

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

    #we've already tested that all info is present on this page so no need to test again

    click_button 'Checkout'

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content("Successfully submitted your order totaling $#{total}")
    #need to add conditional on dashboard page about only listing orders if there are any to list
  end
end
