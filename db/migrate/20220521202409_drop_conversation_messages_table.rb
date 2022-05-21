class DropConversationMessagesTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :conversation_messages
  end
end
