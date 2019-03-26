class AuthController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    @user = User.find_by(username: user_login_params[:username])
    if @user && @user.authenticate(user_login_params[:password])
      token = encode_token({user_id: @user.id})

      @room_and_receiver = @user.rooms.map do |room|
        @receiver = room.users.find do |user|
          user.id != @user.id
        end

        {room: room, receiver: UserSerializer.new(@receiver)}
      end

      @uniq_room_and_receiver = @room_and_receiver.uniq do |r_r|
        r_r[:room].id
      end
      render json: { user: UserSerializer.new(@user), jwt: token, rooms: @uniq_room_and_receiver, messages: @user.messages }, status: :accepted
    else
      render json: { message: "Invalid username or password" }, status: :unauthorized
    end
  end

  private

  def user_login_params
    params.require(:user).permit(:username, :password)
  end
end
