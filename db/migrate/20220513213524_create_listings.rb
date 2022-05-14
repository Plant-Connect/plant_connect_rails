class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.integer :quantity
      t.integer :category
      t.boolean :rooted
      t.references :user, foreign_key: true
      t.references :plant, foreign_key: true

      t.timestamps
    end
  end
end
