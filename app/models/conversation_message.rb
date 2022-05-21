class ConversationMessage < ApplicationRecord
  belongs_to :conversation
  belongs_to :message
end
