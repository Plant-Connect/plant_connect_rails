class Api::V1::ConversationsController < ApplicationController

  def index
    if params[:user_id].blank?
      json_response({ data: { message: 'user_id is required to view conversations' } }, :bad_request)
    else
      user = User.find(params[:user_id])
      conversations = user.conversations
      json_response(ConversationSerializer.new(conversations))
    end 
  end
  
  def show
    conversation = Conversation.find(params[:id])
    if params[:user_id].blank?
      json_response({ data: { message: 'user_id is required to view conversations' } }, :bad_request)
    else
      json_response(ConversationSerializer.new(conversation))
    end
  end
end
