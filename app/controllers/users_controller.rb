class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  ## ログインしていない他人を弾くためのbefore_action
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy] 
  
  ## 管理者かログインしている人かを確認するbefore_action
  before_action :admin_or_correct_user, only: [:edit, :update]
  
  ## 一般でログインしているときに、ユーザー登録を防ぐbefore_action
  before_action :logged_make_user, only: [:new] 
  
  
  before_action :admin_user, only: [:index, :destroy]
  
  def new
    @user = User.new
  end
  
  def index
    @users = User.paginate(page: params[:page], per_page: 20)
  end
  
  def show
  end
  
  def edit
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
    if @user.update_attributes(user_params)
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :edit
    end
  end
  
  def destroy
    if @user.destroy
      flash[:success] = '削除に成功しました。'
      redirect_to users_url
    else
      render :users_url
    end
  end
  
  
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def set_user
      @user = User.find(params[:id])
    end
  
    def logged_in_user
      ## logged_in? は sessions_helper内の関数
      unless logged_in?
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end
    
    def logged_make_user
      ## logged_in? は sessions_helper内の関数
      if logged_in? && !current_user.admin?
        flash[:danger] = "すでにログインしています。"
        redirect_to user_path
      end
    end
    
    ## correct = 正しい　の意味。collect は収集
    ## 管理権限者、または現在ログインしているユーザーを許可します。
    def admin_or_correct_user
      @user = User.find(params[:user_id]) if @user.blank?
      unless current_user?(@user) || current_user.admin?
        flash[:danger] = "編集権限がありません。"
        redirect_to(root_url)
      end  
    end
    
    # システム管理権限所有かどうか判定します。
    def admin_user
      redirect_to root_url unless current_user.admin?
    end
end
