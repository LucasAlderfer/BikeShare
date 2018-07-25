require 'rails_helper'

describe 'visitor sees cart show page' do
  xit 'sees all accessories visitor has added to cart' do
    part_1 = Accessory.create(title: 'thing1', description: 'kjhs', price: 4, status: 0, image: 'hjtkhtjk')
    part_2 = Accessory.create(title: 'thing2', description: 'kjhgt6s', price: 6, status: 0, image: 'IIIII')
    cart = Cart.new(session[:cart])
    cart.add_accessory(part_1.id)
    cart.add_accessory(part_2.id)
    quantity1 = cart.contents[part_1.id.to_s]
    quantity2 = cart.contents[part_2.id.to_s]
    subtotal1 = quantity1 * part_1.price
    subtotal2 = quantity2 * part_2.price
    total = subtotal1 + subtotal2

    visit cart_path(cart)

    expect(page).to have_content(part_1.image)#thumbnail size
    expect(page).to have_content(part_1.title)
    expect(page).to have_content(part_1.price)
    expect(page).to have_content(quantity1)
    expect(page).to have_content(subtotal1)#this is fine here but should be an actual method for the page
    expect(page).to have_content(part_2.image)#thumbnail size
    expect(page).to have_content(part_2.title)
    expect(page).to have_content(part_2.price)
    expect(page).to have_content(quantity2)
    expect(page).to have_content(subtotal2)#this is fine here but should be an actual method for the page
    expect(page).to have_content(total)#this is fine here but should be an actual method for the page

    visit '/login'
    fill_in 'Create Account'

    fill_in :user_username, with: username
    fill_in :user_password, with: password
    click_on 'Submit'

    visit cart_path(cart)

    expect(page).to have_content(part_1.image)#thumbnail size
    expect(page).to have_content(part_1.title)
    expect(page).to have_content(part_1.price)
    expect(page).to have_content(quantity1)
    expect(page).to have_content(subtotal1)#this is fine here but should be an actual method for the page
    expect(page).to have_content(part_2.image)#thumbnail size
    expect(page).to have_content(part_2.title)
    expect(page).to have_content(part_2.price)
    expect(page).to have_content(quantity2)
    expect(page).to have_content(subtotal2)#this is fine here but should be an actual method for the page
    expect(page).to have_content(total)#this is fine here but should be an actual method for the page
  end
end
