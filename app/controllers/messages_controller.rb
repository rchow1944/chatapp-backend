class MessagesController < ApplicationController
  def create
    message = Message.new(message_params)
    room = Room.find(message_params[:room_id])
    if message.save
      serialized_data = ActiveModelSerializers::Adapter::Json.new(
        MessageSerializer.new(message)
      ).serializable_hash
      MessagesChannel.broadcast_to room, serialized_data
      head :ok
    end
    # render json: message
  end

  private

  def message_params
    #code
    params.require(:message).permit(:content, :room_id)
  end
end
