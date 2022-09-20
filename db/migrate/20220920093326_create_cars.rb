class CreateCars < ActiveRecord::Migration[7.0]
  def change
    create_table :cars do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.string :location
      t.float :latitude
      t.float :longitude
      t.float :price_per_day
      t.integer :places
      t.integer :mileage
      t.string :gearbox
      t.boolean :air_conditionning

      t.timestamps
    end
  end
end
