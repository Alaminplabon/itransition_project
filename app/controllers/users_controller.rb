class UsersController < ApplicationController
  before_action :authenticate_user!
  # before_action :admin_access, only: [:admin_dashboard]
  load_and_authorize_resource

  def profile
    @user = User.find(current_user.id)
    @collections = @user.collections
  end

  def admin_dashboard
    @users = User.all
    authorize! :view, @users
  rescue CanCan::AccessDenied
    redirect_to root_path, alert: 'You are not authorized to access this page.'
  end

  def user_details
    @user = User.find_by(id: params[:id])
  end

  def manage_user
    user = User.find_by(id: params[:id])
    if user
      user.update!(is_admin: params[:user][:is_admin], is_block: params[:user][:is_block])
      redirect_to '/admin_dashboard', allow_other_host: true, notice: 'User was successfully updated.'
    end
  end

  def delete_user
    user = User.find_by(id: params[:id])
    if user
      user.destroy
      redirect_to '/admin_dashboard', allow_other_host: true, notice: 'User was successfully deleted.'
    end
  end

  private

  # def admin_access
  #   authorize! :access, :admin_dashboard
  # end
  #

  def user_params
    params.require(:user).permit(:id, :username)
  end
end
