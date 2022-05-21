class Message < ApplicationRecord
  validates_presence_of :content, 
                        :user_id

  belongs_to :user
end
