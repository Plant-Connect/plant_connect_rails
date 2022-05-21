class MessagesController < ApplicationController

  def create
      @message = Message.create(message_params)
      @conversation = Conversation.find(@message[:conversation_id])
      ConversationChannel.broadcast_to(@conversation, @message)
      json_response(@message)
  end

  private
  
    def message_params
        params.permit(:content, :conversation_id, :user_id)
    end

end
