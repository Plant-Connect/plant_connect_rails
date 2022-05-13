class ChangeTypeToPlantTypeOnPlants < ActiveRecord::Migration[5.2]
  def change
    rename_column :plants, :type, :plant_type
  end
end
