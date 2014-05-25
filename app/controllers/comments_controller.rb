class CommentsController < ApplicationController
  before_action :require_user

  def create

    ### ALTERNATIVE ####
    # @post = Post.find(params[:id])
    # @comment = @post.comments.build(params.require(:comment).permit(:body))
    
    @post = Post.find(params[:post_id])
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.post = @post
    @comment.creator = current_user

    if @comment.save
      flash[:notice] = "Your comment was added."
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end
end