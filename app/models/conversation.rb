class Conversation < ApplicationRecord

  has_many :user_conversations
  has_many :users, through: :user_conversations
  has_many :conversation_messages
  has_many :messages, through: :conversation_messages
end
