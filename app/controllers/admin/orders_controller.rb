class Admin::OrdersController < Admin::BaseController

  def update

    @order = Order.find(params[:id])
    @order.update(status: params[:status])
    if @order.save
      flash[:success] = "You have successfully updated Order Number: #{@order.id}"
      redirect_to admin_dashboard_path
    else
      flash[:notice] = "Order was not properly updated"
      render admin_dashboard_path
    end
  end

  private

  def order_params
    params.require(:order).permit(:status, :user_id, :first_name, :last_name, :street, :city, :state, :zip)
  end
end
