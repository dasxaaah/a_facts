class ArticlesController < ApplicationController
  # load_and_authorize_resource class: "Post"
  before_action :authenticate_user!
  # before_action :require_admin!

  def index
    @categories = Article::CATEGORIES
    @selected_category = params[:category].presence

    @articles = Article.order(created_at: :desc)
    @articles = @articles.where(category: @selected_category) if @selected_category
  end


  def show
    @article = Article.find(params[:id])
  end

  private

  def require_admin!
    return if current_user&.admin?

    redirect_to root_path, alert: "Нет доступа"
  end
end

