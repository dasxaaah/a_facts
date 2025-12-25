class Admin::TutorialsController < ApplicationController
    before_action :authenticate_user!

  def index
    @tutorials = Tutorial.order(created_at: :desc)
  end

  def show
    @tutorial = Tutorial.find(params[:id])
  end
end