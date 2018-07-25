class CartsController < ApplicationController
  def create
    accessory = Accessory.find(params[:accessory_id])
    @cart     = Cart.new(session[:cart])
    @cart.add_accessory(accessory.id)
    session[:cart] = @cart.contents
    quantity = @cart.contents[accessory.id.to_s]

    flash[:notice] = "You have added #{accessory.title} to your cart."
    redirect_to accessories_path
  end
end
