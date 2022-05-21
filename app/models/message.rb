class Message < ApplicationRecord
  validates_presence_of :content, 
                        :user_id

  belongs_to :user
  has_many :conversation_messages
  has_many :conversations, through: :conversation_messages
end
