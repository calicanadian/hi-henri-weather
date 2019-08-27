class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.decimal :lon
      t.decimal :lat
      t.string :zipcode
      t.string :country
      t.string :city
      t.integer :display_order

      t.timestamps
    end
  end
end
