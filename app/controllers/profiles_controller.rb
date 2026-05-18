class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @active_tab = params[:tab].presence || "works"
    @show_drafts = params[:view] == "drafts"
    @user = current_user
    @posts = current_user.posts.order(created_at: :desc)
    @favourite_articles = current_user.favourited_articles.order(created_at: :desc)
    @favourite_lessons = current_user.favourited_lessons.order(created_at: :desc)
    @project = Project.new
    @published_projects = current_user.projects.published.order(created_at: :desc)
    @draft_projects = current_user.projects.drafts.order(created_at: :desc)
  end
end
