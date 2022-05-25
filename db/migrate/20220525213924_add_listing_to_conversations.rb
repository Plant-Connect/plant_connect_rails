class AddListingToConversations < ActiveRecord::Migration[5.2]
  def change
    add_reference :conversations, :listing, foreign_key: true
  end
end
