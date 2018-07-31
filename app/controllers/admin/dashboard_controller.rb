class Admin::DashboardController < Admin::BaseController

  def index
    if (params[:status] != 'all') && (params[:status] != '')
      @orders = Order.where(status: params[:status])
    else
      @orders = Order.all
    end
    @ordered = Order.cnt_ordered
    @completed = Order.cnt_completed
    @paid = Order.cnt_paid
    @cancelled = Order.cnt_cancelled
  end

end
