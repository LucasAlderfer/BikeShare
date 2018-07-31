class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
  end

  def create
    @order = current_user.orders.create(order_params)
    session[:cart] = nil

    @cart.contents.each do |id, quantity|
      @order.order_accessories.create(quantity: quantity, accessory_id: id.to_i)
    end

    flash[:success] = "Successfully submitted your order totaling $#{@order.total}"
    redirect_to '/dashboard'
  end

  private

  def order_params
    params.require(:order).permit(:status,
                                  :user_id,
                                  :created_at,
                                  :updated_at,
                                  :first_name,
                                  :last_name,
                                  :street,
                                  :city,
                                  :state,
                                  :zip)
  end
end
