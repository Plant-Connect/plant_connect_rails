class CreateConversationMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :conversation_messages do |t|
      t.references :conversation, foreign_key: true
      t.references :message, foreign_key: true

      t.timestamps
    end
  end
end
