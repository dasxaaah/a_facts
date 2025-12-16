class TutorialsController < ApplicationController
    before_action :authenticate_user!

  def index
    @tutorials = Post.where(post_type: 1)  
  end

  def show
    @tutorial = Post.find(params[:id])
  end
end