class CreateZipcodesDistricts < ActiveRecord::Migration[5.1]
  def change
    create_table :zipcodes_districts do |t|
      t.string :state, limit: 2, null: false
      t.string :zipcode, limit: 5, null: false
      t.string :district, null: false

      t.timestamps
    end

    add_index :zipcodes_districts, :state
    add_index :zipcodes_districts, :zipcode
    add_foreign_key :zipcodes_districts, :states, column: :state, primary_key: :state
  end
end
