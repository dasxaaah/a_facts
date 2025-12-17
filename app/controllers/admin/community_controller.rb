class Admin::CommunityController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.where(post_type: 1)  
  end

  def show
    @post = Post.find(params[:id])
  end
end
