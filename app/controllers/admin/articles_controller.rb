class Admin::ArticlesController < ApplicationController
  def index
    @articles = Post.where(post_type: 1)
  end

  def show
    @article = Post.find(params[:id])
  end
end