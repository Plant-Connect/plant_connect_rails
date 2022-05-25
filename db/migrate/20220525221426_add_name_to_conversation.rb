class AddNameToConversation < ActiveRecord::Migration[5.2]
  def change
    add_column :conversations, :name, :string
  end
end
