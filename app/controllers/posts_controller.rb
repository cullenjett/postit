class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show]


  def index 
    @posts = Post.all.sort_by{ |e| e.total_votes }.reverse
  end


  def show
    @comment = Comment.new
  end


  def new
    @post = Post.new
  end


  def create
    @post = Post.new(post_params)
    @post.creator = current_user

    if @post.save
      flash[:notice] = "Your post was saved."
      redirect_to posts_path
    else #validation error
      render 'new' #rendering allows us to display the errors
    end
  end


  def edit

  end


  def update
    if @post.update(post_params)
      flash[:notice] = "The post has been updated."
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end


  def vote
    vote = Vote.create(voteable: @post, vote: params[:vote], creator: current_user)

    if vote.valid?
      flash[:notice] = "Your vote was counted."
      redirect_to :back
    else
      flash[:error] = "You can only vote on a post once."
      redirect_to :back
    end
  end


  private

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end


  def set_post
    @post = Post.find(params[:id])
  end
end
