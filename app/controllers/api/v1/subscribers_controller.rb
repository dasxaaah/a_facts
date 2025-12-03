class Api::V1::SubscribersController < ApplicationController
  skip_before_action :verify_authenticity_token  

  def create
    @subscriber = Subscriber.new(subscriber_params)

    if @subscriber.save
      render json: {
        success: true,
        success_text: "Спасибо! Вы подписаны."
      }, status: :created
    else
      render json: {
        success: false,
        error_text: "Ошибка, проверьте e-mail.",
        errors: @subscriber.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  private

  def subscriber_params
    params.require(:subscriber).permit(:email)
  end
end