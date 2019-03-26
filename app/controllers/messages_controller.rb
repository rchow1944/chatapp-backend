class MessagesController < ApplicationController
  def create
    # byebug
    @message = Message.create(content: message_params[:content], user_id: current_user.id, room_id: 1)
    render json: @message
  end

  private

  def message_params
    #code
    params.require(:message).permit(:content)
  end
end
