class UsersController < ApplicationController
  
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :edit
    end
  end
  
  def destroy
    if @task.destroy
      flash[:success] = '削除に成功しました。'
      redirect_to user_tasks_url
    else
      render :user_tasks_url
    end
  end
  
  
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
