class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def index
    # @users = User.all.map do |user|
    #   UserSerializer.new(user)
    # end
    #
    # render json: { users: @users}
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      @token = encode_token(user_id: @user.id)
      render json: { user: UserSerializer.new(@user), jwt: @token }, status: :created
    else
      render json: { error: 'Username already exists' }, status: :not_acceptable
    end
  end

  def messages
    render json: { user: UserSerializer.new(current_user), rooms: current_user.rooms }, status: :accepted
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :password)
  end
end
