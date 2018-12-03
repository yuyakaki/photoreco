class PostsController < ApplicationController
  before_action :require_user_logged_in
  
  def new
    @post = current_user.posts.build # form_for 用
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "投稿しました。"
      redirect_to root_url
    else
      flash[:danger] = "投稿に失敗しました。"
      render :new
    end
  end
  
  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end

  def destroy
  end
  
  
  private
  
  def post_params
    params.require(:post).permit(:title, :image_name, :content)
  end
end
