class Admin::DashboardController < Admin::BaseController

  def index
    @orders = Order.all
    @ordered = Order.cnt_ordered
    @completed = Order.cnt_completed
    @paid = Order.cnt_paid
    @cancelled = Order.cnt_cancelled
  end

end
