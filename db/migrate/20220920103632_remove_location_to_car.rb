class RemoveLocationToCar < ActiveRecord::Migration[7.0]
  def change
    remove_column :cars, :location
  end
end
