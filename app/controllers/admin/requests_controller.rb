class Admin::RequestsController < AdminBaseController
  def index
    @requests = Request.includes(:user).order(created_at: :desc).limit(100)
  end
end
