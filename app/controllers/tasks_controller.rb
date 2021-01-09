class TasksController < ApplicationController
  
  def index
    @user = User.find(params[:user_id])
    @tasks = Task.where(user_id: @user.id)
  end
  
  
    private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  endzs
end
