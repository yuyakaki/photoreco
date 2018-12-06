class PostsController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create, :destroy]
  
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
    @comments = @post.comments
    @comment = Comment.new
    @likes_count = Like.where(post_id: @post.id).count
  end

  def destroy
    @post = Post.find_by(user_id: @current_user.id, id: params[:id])
    
    if @post.destroy
      flash[:success] = "投稿を削除しました。"
      redirect_to root_url
    else
      flash[:danger] = "削除に失敗しました。"
      redirect_back(fallback_location: root_path)
    end
  end
  
  
  private
  
  def post_params
    params.require(:post).permit(:title, :image_name, :content)
  end
end
