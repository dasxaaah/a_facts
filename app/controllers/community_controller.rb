class CommunityController < ApplicationController
  before_action :authenticate_user!

  def index
    @active_tab = params[:tab].presence || "discussions"

    @posts = Post.includes(:user)
                 .order(id: :desc)
                 .paginate(page: params[:page], per_page: 10)
    @contest_submissions_by_slug = ContestSubmission.includes(:user).order(created_at: :desc).group_by(&:contest_slug)

    # @meetups = Meetup.all
    # @works = Work.all
    # @contests = Contest.all
  end

  def show
    @post = Post.find(params[:id])
  end
end
