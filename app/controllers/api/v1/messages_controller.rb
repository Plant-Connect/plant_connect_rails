class Api::V1::MessagesController < ApplicationController

  def create
    # FE will return a conversation_id *if* the conversation already exists.
    # If they don't return a conversation_id, we will assume this is a new convo
    # and create a conversation_id to include in our response
    if params[:user_id].blank?
      json_response({ data: { message: 'user_id param missing or empty' } }, :bad_request)
    else
      if params[:message][:conversation_id].blank? 
        conversation = Conversation.create!()
        message = Message.create!(content: params[:message][:content], user_id: params[:message][:user_id], conversation_id: conversation.id)
      else 
        conversation = Conversation.find_by_id(params[:message][:conversation_id])
        message = Message.create(message_params)
      end
      create_user_conversations(params[:user_id], params[:listing_id], conversation)
      ConversationChannel.broadcast_to(conversation, message)
      json_response(MessageSerializer.new(message), :created)
    end 
  end

  private
  
    def message_params
      params.require(:message).permit(:content, :conversation_id, :user_id)
    end

    def create_user_conversations(user1_id, user2_listing, conversation)
      user2 = Listing.find_by_id(user2_listing).user
      UserConversation.create!(user_id: user1_id, conversation_id: conversation.id)
      UserConversation.create!(user_id: user2.id, conversation_id: conversation.id)
    end
end
