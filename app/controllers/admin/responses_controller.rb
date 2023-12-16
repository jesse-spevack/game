class Admin::ResponsesController < AdminBaseController
  def destroy
    Commands::DeleteAllResponses.call
    redirect_to admin_path
  end
end
