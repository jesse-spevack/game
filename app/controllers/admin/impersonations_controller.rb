class Admin::ImpersonationsController < AdminBaseController
  def create
    impersonatee = User.find_by(id: impersonation_params[:user_id])
    result = Commands::CreateImpersonation.call(impersonator: @current_user, impersonatee: impersonatee)

    if result.success
      session[:impersonation_id] = result.impersonation.id

      impersonator = result.impersonator
      impersonatee = result.impersonatee

      session[:user_id] = impersonatee.id
      flash[:notice] = "Admin user #{impersonator.email} is logged in as #{impersonatee.email}"

      @current_user = impersonatee

      redirect_to players_path
    else
      flash[:error] = "Could not login in as user"
      redirect_to admin_users_path
    end
  end

  def destroy
    result = Commands::ConcludeImpersonation.call(impersonation_id: session[:impersonation_id])

    if result.success
      session[:impersonation_id] = nil
      session[:user_id] = result.current_user.id
      @current_user = result.current_user
      flash[:notice] = "You are logged in as #{result.current_user.email}"
    else
      flash[:error] = "Something went wrong. Could not stop impersonating user."
    end
    redirect_to admin_user_path(result.impersonation.impersonatee)
  end

  private

  def impersonation_params
    params.permit(:user_id, :authenticity_token)
  end
end
