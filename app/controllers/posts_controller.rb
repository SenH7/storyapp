class PostsController < ApplicationController
  before_action :require_login, only: [:new, :create, :edit, :update, :destroy, :my_posts]

  def new
    @post = Post.new
  end

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to post_path(@post), notice: 'Post created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def my_posts
    @posts = current_user.posts.order(created_at: :desc)
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: 'Post updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    redirect_to my_posts_path, notice: 'Post deleted.'
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
