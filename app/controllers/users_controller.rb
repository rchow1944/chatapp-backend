class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def index
    byebug
    @users = User.all.map do |user|
      UserSerializer.new(user)
    end

    render json: { allUsers: @users }
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
    @room_and_receiver = current_user.rooms.map do |room|
      {room: room, receiver: UserSerializer.new(room.users[1])}
    end
    render json: { user: UserSerializer.new(current_user), rooms: @room_and_receiver, messages: current_user.messages }, status: :accepted
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :password)
  end
end
