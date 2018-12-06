class CommentsController < ApplicationController
  before_action :require_user_logged_in, only: [:create]
  
  def create
    
    @comment = Comment.new(comment_params)
      
    if @comment.save 
      flash[:success] = "投稿にコメントしました。"
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "コメントに失敗しました。"
    end
  end
  
  
  private
  
  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :content)
  end
end



