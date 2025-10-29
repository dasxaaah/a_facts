class SubscribersController < ApplicationController
  def create
    @subscriber = Subscriber.new(subscriber_params)
    if @subscriber.save
      flash[:notice] = "Спасибо! Вы подписаны."
      redirect_to coming_soon_path
    else
      flash[:alert] = "Ошибка, проверьте e-mail."
      redirect_to coming_soon_path
    end
  end

  private

  def subscriber_params
    params.require(:subscriber).permit(:email)
  end
end
