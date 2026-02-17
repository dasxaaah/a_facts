class WelcomeController < ApplicationController
  def index
    @subscription = Subscriber.new

    unless cookies[:jwt]
      uuid = SecureRandom.uuid
      payload = { guest_id: uuid }
      jwt_signing_key = Rails.application.credentials.jwt_signing_key!
      token   = JWT.encode(payload, jwt_signing_key, 'HS256')
      cookies[:jwt] = token
    end       
  end

  def about
  end
end