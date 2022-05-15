class RemoveDescriptionFromPlants < ActiveRecord::Migration[5.2]
  def change
    remove_column :plants, :description
  end
end
