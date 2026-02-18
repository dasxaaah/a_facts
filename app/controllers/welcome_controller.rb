class WelcomeController < ApplicationController
  def index
    @subscription = Subscriber.new
  end

  def about
  end
end