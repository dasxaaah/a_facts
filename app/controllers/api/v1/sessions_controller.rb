class Api::V1::SessionsController < Devise::SessionsController
    skip_before_action :verify_authenticity_token

    def create
        # unless cookies[:jwt]
        #     uuid = SecureRandom.uuid
        #     payload = { guest_id: uuid }
        #     jwt_signing_key = Rails.application.credentials.jwt_signing_key!
        #     token   = JWT.encode(payload, jwt_signing_key, 'HS256')
        #     cookies[:jwt] = token
        # end   
        puts params
        render json: {success_text: "Signed in successfully"}, status: :created
    end    
end