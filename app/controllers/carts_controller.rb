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
    if params[:new_quantity].to_i > 0
      @cart.contents[params[:id]] = params[:new_quantity].to_i
      redirect_to cart_path
    else
      flash[:warning] = "Invalid quantity"
      redirect_to cart_path
    end
  end

  def destroy
    @cart.contents.delete(params[:id])
    accessory = Accessory.find(params[:id])
    link = "<a href='/accessories/#{accessory.id}'>#{accessory.title}</a>".html_safe
    flash[:remove] = "Successfully removed #{link} from your cart".html_safe
    redirect_to cart_path
  end
end
