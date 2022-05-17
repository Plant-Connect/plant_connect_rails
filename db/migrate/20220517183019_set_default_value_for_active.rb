class SetDefaultValueForActive < ActiveRecord::Migration[5.2]
  def change
    change_column :listings, :active, :boolean, default: true
  end
end
