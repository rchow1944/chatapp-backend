class RoomsController < ApplicationController
  def create
    # if room.save
    #   serialized_data = ActiveModelSerializers::Adapter::Json.new(
    #     RoomSerializer.new(room)
    #   ).serializable_hash
    #   ActionCable.server.broadcast 'rooms_channel', serialized_data
    #   head :ok
    # end
    @room = Room.create()

    @receiver = User.find_by(username: room_params[:username])
    @sender = current_user

    @sender_message = Message.create({user_id: @sender.id, content: "Hello", room_id: @room.id})
    @receiver_message = Message.create({user_id: @receiver.id, content: "Hello", room_id: @room.id})

    render json: { room: @room, room_messages: @room.messages, room_users: @room.users }
  end

  def index
    rooms = Room.all
    render json: rooms
  end

  def show
  end

  private

  def room_params
    #code
    params.require(:room).permit(:username, :first_name, :last_name)
  end
end
