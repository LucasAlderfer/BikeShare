require 'rails_helper'

describe 'visitor sees cart show page' do
  it 'sees all accessories visitor has added to cart' do
    part_1 = Accessory.create(title: 'thing1', description: 'kjhs', price: 4, status: 0, image: 'http://placekitten/200/200')
    part_2 = Accessory.create(title: 'thing2', description: 'kjhgt6s', price: 6, status: 0, image: 'http://placekitten/200/200')
    quantity1 = 1
    quantity2 = 1
    subtotal1 = 4
    subtotal2 = 6
    total     = 10

    visit '/bike-shop'

    within "#accessory-#{part_1.id}" do
      click_on 'Add to Cart'
    end

    within "#accessory-#{part_2.id}" do
      click_on 'Add to Cart'
    end

    visit cart_path

    expect(page).to have_content(part_1.title)
    expect(page).to have_content(part_1.price)
    expect(page).to have_content(quantity1)
    expect(page).to have_content(subtotal1)#this is fine here but should be an actual method for the page
    expect(page).to have_content(part_2.title)
    expect(page).to have_content(part_2.price)
    expect(page).to have_content(quantity2)
    expect(page).to have_content(subtotal2)#this is fine here but should be an actual method for the page
    expect(page).to have_content(total)#this is fine here but should be an actual method for the page

    username = 'Angela'
    password = 'Bong_angel_132'

    visit '/login'

    click_on 'Create New Account'

    fill_in :user_username, with: username
    fill_in :user_password, with: password

    click_on 'Submit'

    visit cart_path

    expect(page).to have_content(part_1.title)
    expect(page).to have_content(part_1.price)
    expect(page).to have_content(quantity1)
    expect(page).to have_content(subtotal1)#this is fine here but should be an actual method for the page
    expect(page).to have_content(part_2.title)
    expect(page).to have_content(part_2.price)
    expect(page).to have_content(quantity2)
    expect(page).to have_content(subtotal2)#this is fine here but should be an actual method for the page
    expect(page).to have_content(total)#this is fine here but should be an actual method for the page
  end
  it 'can delete accessories from cart' do
    part_1 = Accessory.create(title: 'thing1', description: 'kjhs', price: 4, status: 0, image: 'http://placekitten/200/200')

    visit '/bike-shop'

    within "#accessory-#{part_1.id}" do
      click_on 'Add to Cart'
    end

    visit cart_path

    within "#accessory-#{part_1.id}" do
      click_link 'Remove'
    end

    expect(current_path).to eq(cart_path)
    expect(page).to have_content("Successfully removed #{part_1.title} from your cart")

    within ".remove" do
      expect(page).to have_link("#{part_1.title}")
    end

    within ".cart" do
      expect(page).to_not have_content(part_1.title)
    end
  end
end
