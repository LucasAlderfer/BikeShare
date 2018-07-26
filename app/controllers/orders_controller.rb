class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end

  def create
    @order = current_user.orders.create
    @cart.contents.each do |id, quantity|
      @order.order_accessories.create(quantity: quantity, accessory_id: id.to_i)
    end

    flash[:success] = "Successfully submitted your order totaling $#{@order.total}"
    redirect_to '/dashboard'

  end
end
