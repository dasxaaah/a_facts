class Api::V1::SessionsController < Devise::SessionsController
  include JwtAuth
  skip_before_action :verify_authenticity_token, only: [:authorize_by_jwt, :create, :destroy]
  skip_before_action :verify_signed_out_user, only: :destroy
  before_action :load_user_by_email, only: [:create]
  before_action :load_user_by_jti, only: [:authorize_by_jwt]

  def authorize_by_jwt
    puts @user.to_json

    render json: {
      messages: 'Authorized successfully',
      is_success: true,
      email: @user.email
    }, status: :ok
  end 

  def create
    if @user&.valid_password?(sign_in_params[:password])
      # sign_in(@user)

      render json: {
        messages: "Sign in successfully",
        is_success: true,
        jwt: encrypt_payload
      }, status: :ok
    else
      render json: {
        messages: "Password is incorrect",
        is_success: false
      }, status: :unauthorized
    end
  end

  def destroy
    if @user && @user.update_column(:jti, SecureRandom.uuid)
      render json: {
        messages: "Signed Out Successfully",
        is_success: true,
      }, status: :ok
    else
      render json: {
        messages: "Sign Out Failed - Unauthorized",
        is_success: false
      }, status: :unauthorized
    end
  end

  private

  def load_user_by_email
      @user = User.find_for_database_authentication(email: sign_in_params[:email])

      unless @user
        render json: {
          messages: "Sign In Failed - Unauthorized",
          is_success: false,
        }, status: :unauthorized
      end
  end

  
end