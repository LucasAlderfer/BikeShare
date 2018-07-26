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

  def index
    accessory_ids = @cart.accessory_ids
    @cart_items = Accessory.find(accessory_ids)
  end

  def update
    @cart.contents[params[:id]] = params[:new_quantity].to_i
    redirect_to cart_path
  end

  def destroy
    @cart.contents.delete(params[:id])
    flash[:remove] = "Successfully removed #{Accessory.find(params[:id]).title} from your cart"
    redirect_to cart_path
  end
end
