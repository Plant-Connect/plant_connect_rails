class CreatePlants < ActiveRecord::Migration[5.2]
  def change
    create_table :plants do |t|
      t.string :photo
      t.string :type
      t.text :description
      t.boolean :indoor
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
