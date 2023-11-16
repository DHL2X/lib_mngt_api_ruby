class CurrentUserController < ApplicationController
  before_action :authenticate_user!
  def index
    render json: UserSerializer.new(current_user).serializable_hash[:data][:attributes], status: :ok
  end

  def update_password
    user = current_user
    if user.valid_password?(password_params[:current_password])
      if password_params[:password]==password_params[:password_confirmation] && user.update(password:password_params[:password])
        render json: { status: 'ok' }, status: :ok
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { errors: ['Current password is incorrect'] }, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user.destroy
      render json: { status: 'ok' }, status: :ok
    end
    rescue => e
      render json: { errors: ["Error: #{e.full_message}"] }, status: :unprocessable_entity
  end

  private

  def password_params
    params.permit(:current_password, :password, :password_confirmation)
  end
  
end
