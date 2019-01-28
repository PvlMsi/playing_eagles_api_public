class V1::UsersController < ApplicationController
  skip_before_action :authenticate_request, only: %i[login create]
  before_action :set_user, only: %i[show update destroy]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, except: :password_digest, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user, except: :password_digest
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  def login
    authenticate params[:email], params[:password]
  end

  private

  def authenticate(email, password)
    command = AuthenticateUser.call(email, password)
    if command.success?
      render json: {
        access_token: command.result[:token],
        user_id: command.result[:id],
        message: 'Login Successful',
        expiration_date: Time.now + 2.hours
      }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit(
      :login, :password,
      :email, :first_name,
      :last_name, :birth_date,
      :phone_number, :city, :street
    )
  end
end
