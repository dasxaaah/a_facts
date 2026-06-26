class WelcomeController < ApplicationController
  def index
    @subscription = Subscriber.new
    @home_articles = Article.order(Arel.sql("RANDOM()")).limit(6)
    @home_posts = Post.with_rich_text_body.includes(:user, :comments, :likes).order(created_at: :desc).limit(2)
    @contest_submissions_by_slug = ContestSubmission.includes(:user).order(created_at: :desc).group_by(&:contest_slug)
  end

  def about
  end
end
