class CommunityController < ApplicationController
  before_action :authenticate_user!

  def index
    @active_tab = params[:tab].presence || "discussions"

    @posts = Post.order(id: :desc)

    # @meetups = Meetup.all
    # @works = Work.all
    # @contests = Contest.all
  end
end