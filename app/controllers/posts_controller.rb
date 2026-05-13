class PostsController < ApplicationController
  load_and_authorize_resource
  # before_action :authenticate_user!
  # before_action :set_post, only: %i[show edit update destroy]
  # before_action :authorize_post!, only: %i[edit update destroy]
   def index
    @posts = Post.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end
  
  def toggle_favourite
    FavouritePost.create(user_id: current_user.id, post_id: @post.id)
  end

  def new
    @post = Post.new
  end

  def edit
  end

def create
  @post = current_user.posts.build(post_params)

  if @post.save
    redirect_to community_index_path(tab: "discussions"), notice: "Вопрос опубликован"
  else
    @posts = Post.order(id: :desc)
    @active_tab = "discussions"
    render "community/index", status: :unprocessable_entity
  end
end

  def update
    if @post.update(post_params)
      redirect_to community_index_path(tab: "discussions"), notice: "Пост обновлён", status: :see_other    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to community_index_path(tab: "discussions"), notice: "Пост удалён"
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_post!
    return if current_user&.admin?
    return if @post.user == current_user

    redirect_to posts_path, alert: "Нет доступа"
  end

  def post_params
    params.require(:post).permit(:body, :post_type, :post_image)
  end
end
