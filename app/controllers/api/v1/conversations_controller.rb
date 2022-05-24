class Api::V1::ConversationsController < ApplicationController

  def index
    if params[:user_id].blank?
      json_response({ data: { message: 'user_id is required to view conversations' } }, :bad_request)
    else
      user = User.find_by_id(params[:user_id])
      conversations = user.conversations
      json_response(ConversationSerializer.new(conversations))
    end 
  end
  
  def show
    if params[:user_id].blank? || params[:id].blank?
      json_response({ data: { message: 'user_id and conversation_id are required' } }, :bad_request)
    else
      conversation = Conversation.find(params[:id])
      json_response(ConversationSerializer.new(conversation))
    end
  end
end
