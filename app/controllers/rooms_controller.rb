class RoomsController < ApplicationController
  def create
    room = Room.new(room_params)
    if room.save
      serialized_data = ActiveModelSerializers::Adapter::Json.new(
        RoomSerializer.new(room)
      ).serializable_hash
      ActionCable.server.broadcast 'rooms_channel', serialized_data
      head :ok
    end
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
    params.require(:room).permit(:title)
  end
end
