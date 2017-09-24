class CreateZipcodes < ActiveRecord::Migration[5.1]
  def change
    create_table :zipcodes do |t|
      t.string :zipcode, limit: 5
      t.string :zipcode_type
      t.string :city
      t.string :state, limit: 2
      t.string :location_type
      t.float :latitude
      t.float :longitude
      t.string :world_region
      t.string :country, limit: 2
      t.string :location_text
      t.boolean :decomissioned, null: false, default: false

      t.timestamps
    end

    add_index :zipcodes, :zipcode
    add_index :zipcodes, :city
    add_index :zipcodes, :country
    add_index :zipcodes, :location_text

    add_foreign_key :zipcodes, :states, column: :state, primary_key: :state
  end
end
