class TutorialsController < ApplicationController
    before_action :authenticate_user!

  def index
    @tutorials = Article.where(post_type: 1)  
  end

  def show
    @tutorial = Article.find(params[:id])
  end
end