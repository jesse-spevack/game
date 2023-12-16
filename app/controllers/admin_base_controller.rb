class AdminBaseController < ApplicationController
  before_action :authenticate_admin

  def authenticate_admin
    @current_user.admin? || redirect_to(root_path)
  end
end
