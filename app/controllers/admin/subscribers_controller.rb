class Admin::SubscribersController < ApplicationController
  load_and_authorize_resource
  # before_action :authenticate_user!
  # before_action :authorize_admin!

  def index
    @subscribers = Subscriber.order(created_at: :desc)
  end

  def destroy
    @subscriber = Subscriber.find(params[:id])
    @subscriber.destroy
    redirect_to admin_subscribers_path, notice: "Подписчик удалён"
  end

  private

  def authorize_admin!
    redirect_to root_path, alert: "Нет доступа" unless current_user&.admin?
  end
end