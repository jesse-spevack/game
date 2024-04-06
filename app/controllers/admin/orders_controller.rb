class Admin::OrdersController < AdminBaseController
  def index
    @orders = Order.all
  end
end
