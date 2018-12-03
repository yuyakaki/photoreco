class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit]
  
  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order('created_at DESC').page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "ユーザを登録しました。"
      
      session[:user_id] = @user.id
      
      redirect_to @user
    else
      flash[:danger] = "ユーザの登録に失敗しました。"
      
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      flash[:success] = "編集に成功しました。"
      redirect_to @user
    else
      flash[:danger] = "編集に失敗しました。"
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "アカウントを削除しました。"
    redirect_back(fallback_location: root_path)
  end
end


private

def user_params
  params.require(:user).permit(:name, :image_name, :content, :email, :password, :password_confirmation)
end