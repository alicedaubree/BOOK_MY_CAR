class RemoveLatandLongToCar < ActiveRecord::Migration[7.0]
  def change
    remove_column :cars, :latitude
    remove_column :cars, :longitude
  end
end
