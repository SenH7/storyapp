class Api::V1::PostsController < Api::V1::BaseController
  skip_before_action :authenticate_api_request, only: [:index, :show]

  def index
    @posts = Post.all.order(created_at: :desc)
    render json: @posts
  end

  def show
    @post = Post.find(params[:id])
    render json: @post, include: ['comments', 'user']
  end

  def create
    @post = current_api_user.posts.build(post_params)

    if @post.save
      render json: @post, status: :created
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @post = current_api_user.posts.find(params[:id])

    if @post.update(post_params)
      render json: @post
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @post = current_api_user.posts.find(params[:id])
    @post.destroy
    head :no_content
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end