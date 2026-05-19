class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    load_profile
  end

  def update
    @user = current_user
    attributes = profile_params
    attributes = attributes.except(:password, :password_confirmation) if attributes[:password].blank?

    if @user.update(attributes)
      bypass_sign_in(@user) if attributes.key?(:password) || attributes.key?(:email)
      redirect_to profile_path(tab: "settings"), notice: "Профиль обновлён"
    else
      load_profile
      @active_tab = "settings"
      render :show, status: :unprocessable_entity
    end
  end

  private

  def load_profile
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

  def profile_params
    params.require(:user).permit(:name, :nickname, :email, :password, :password_confirmation)
  end
end
