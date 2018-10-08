class UsersController < ApplicationController
  before_action :authenticate_user!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  after_action  :verify_authorized

  def index
    @users = User.all
    authorize @users
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    user.destroy
    redirect_to users_path, :notice => "User deleted"
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if User.roles.keys.include?(params[:user][:role])
      if @user.update_attributes(secure_params)
        flash[:notice] = "User updated"
      else
        flash[:alert] = "Unable to update user"
      end
    else
      flash[:alert] = "Invalid user role selection"
    end
    redirect_to users_path
  end

  private
    def secure_params
      params.require(:user).permit(:role)
    end
end
