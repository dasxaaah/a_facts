class WelcomeController < ApplicationController
  def index
    @subscription = Subscriber.new
  end

  def about
  end
  def index
  @home_articles = Article.order(Arel.sql("RANDOM()")).limit(6)
end
end