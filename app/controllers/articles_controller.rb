class ArticlesController < ApplicationController
  # load_and_authorize_resource class: "Post"
  before_action :authenticate_user!
  # before_action :require_admin!

  def index
    @articles = Post.where(post_type: 1).order(created_at: :desc)
  end

  def show
    @article = Post.find(params[:id])
  end

  private

  def require_admin!
    return if current_user&.admin?

    redirect_to root_path, alert: "Нет доступа"
  end
end