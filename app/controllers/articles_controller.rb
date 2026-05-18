class ArticlesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Article::CATEGORIES
    @selected_category = params[:category].presence

    @articles = Article.order(id: :desc)
    @articles = @articles.where(category: @selected_category) if @selected_category
  end

  def show
    @article = Article.find(params[:id])
    @related_articles = Article.where.not(id: @article.id).order(Arel.sql("RANDOM()")).limit(4)
  end

  def toggle_favourite
    @article = Article.find(params[:id])

    favourite_article = FavouriteArticle.find_by(
      user_id: current_user.id,
      article_id: @article.id
    )

    if favourite_article
      favourite_article.destroy
    else
      FavouriteArticle.create(
        user_id: current_user.id,
        article_id: @article.id
      )
    end

    redirect_back fallback_location: article_path(@article)
  end

  private

  def require_admin!
    return if current_user&.admin?

    redirect_to root_path, alert: "Нет доступа"
  end
end
