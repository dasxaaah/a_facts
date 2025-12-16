class Api::V1::WelcomeController < ApplicationController
  def index
    posts = Post.all
    render json: posts
  end

  def preview 
    posts = User.first.posts
    render json: posts
  end
end
