class ContestSubmissionsController < ApplicationController
  before_action :authenticate_user!

  CONTEST_SLUGS = %w[contest_portal contest_object contest_effect].freeze

  def create
    contest_slug = params[:contest_slug].to_s

    unless CONTEST_SLUGS.include?(contest_slug)
      redirect_back fallback_location: community_index_path(tab: "contests"), alert: "Конкурс не найден."
      return
    end

    submission = current_user.contest_submissions.build(
      contest_slug: contest_slug,
      image: params[:image]
    )

    if submission.save
      redirect_back fallback_location: community_index_path(tab: "contests"), notice: "Кейс загружен."
    else
      redirect_back fallback_location: community_index_path(tab: "contests"), alert: "Не удалось загрузить кейс."
    end
  end
end
