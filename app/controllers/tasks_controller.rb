class TasksController < ApplicationController
  before_action :set_user
  before_action :set_task
  
  ## ログインしていない他人を弾くためのbefore_action
  before_action :logged_in_user
  
  ## ログインしている他人のアクセスを弾くためのbefore_action
  before_action :correct_user
  before_action :correct_task, only: [:edit, :update]
  
  def new
  end
  
  def index
    @tasks = Task.where(user_id: @user.id)
  end
  
  def show
  end
  
  def edit
  end
  
  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = '新規作成に成功しました。'
      redirect_to user_tasks_url
    
    else
      render :new
    end
  end
  
  def update
    if @task.update_attributes(task_params)
      flash[:success] = '新規作成に成功しました。'
      redirect_to user_tasks_url
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
    
  def set_user
    @user = User.find(params[:user_id])
  end
  
  
  def set_task
    if params[:id]
      @task = Task.find(params[:id])
    else
      @task = Task.new
    end
  end
  
  def task_params
    params.require(:task).permit(:index, :contents, :user_id)
  end
  
    
  def logged_in_user
    ## logged_in? は sessions_helper内の関数
    unless logged_in?
      flash[:danger] = "ログインしてください。"
      redirect_to login_url
    end
  end
  
    ## correct = 正しい　の意味。collect は収集
  def correct_user
    redirect_to(root_url) unless current_user?(@user)
  end

  def correct_task
    unless current_user_task?(@user, @task)
      flash[:danger] = "編集権限がありません。"
      redirect_to(root_url)
    end  
  end
  
  def current_user_task?(user, task)
    user.id == task.user_id
  end
end
