class MessagesController < ApplicationController
  def create
    # byebug
    @message = Message.create(content: message_params[:content], user_id: current_user.id, room_id: message_params[:room_id])
    render json: @message
  end

  private

  def message_params
    #code
    params.require(:message).permit(:content, :room_id)
  end
end
