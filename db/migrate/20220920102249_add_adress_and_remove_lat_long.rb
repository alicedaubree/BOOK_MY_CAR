class AddAdressAndRemoveLatLong < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :address, :string, null: false
    remove_column :cars, :latitude
    remove_column :cars, :longitude
  end
end
