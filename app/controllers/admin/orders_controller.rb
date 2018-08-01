class Admin::OrdersController < Admin::BaseController

  def update

    @order = Order.find(params[:id])
    @order.update(status: params[:status])
    if @order.save
      flash[:success] = "You have successfully updated Order Number: #{@order.id}"
      redirect_to admin_dashboard_path
    end
  end
end
