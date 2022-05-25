class Conversation < ApplicationRecord

  has_many :user_conversations
  has_many :users, through: :user_conversations
  has_many :messages

  belongs_to :listing
end
