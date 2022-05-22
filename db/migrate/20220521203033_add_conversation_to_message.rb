class AddConversationToMessage < ActiveRecord::Migration[5.2]
  def change
    add_reference :messages, :conversation, index: true
  end
end
