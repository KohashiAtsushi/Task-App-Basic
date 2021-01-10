class TasksController < ApplicationController
  before_action :get_user
  before_action :get_task
  
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
    
  def get_user
    @user = User.find(params[:user_id])
  end
  
  def get_task
    if params[:id]
      @task = Task.find(params[:id])
    else
      @task = Task.new
    end
  end
  def task_params
    params.require(:task).permit(:index, :contents, :user_id)
  end
end
