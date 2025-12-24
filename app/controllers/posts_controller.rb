class PostsController < ApplicationController
  load_and_authorize_resource
  # before_action :authenticate_user!
  # before_action :set_post, only: %i[show edit update destroy]
  # before_action :authorize_post!, only: %i[edit update destroy]
  def show
    @post = Post.find(params[:id])

    set_meta_tags(
      title:'TEST TITLE' @post.title'',
      description: "TEST Ask question in community page",
      keywords: %w[questions answers community vfx],
      
    )
  end
  def index
    @posts = Post.order(created_at: :desc)
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to post_path(@post), notice: "Пост создан"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "Пост обновлён", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "Пост удалён", status: :see_other
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
    params.require(:post).permit(:title, :body, :post_type)
  end
end