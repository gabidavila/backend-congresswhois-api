class CreateCities < ActiveRecord::Migration[5.1]
  def change
    create_table :cities do |t|
      t.string :city
      t.string :state
      t.string :county
      t.string :city_alias

      t.timestamps
    end

    add_foreign_key :cities, :states, column: :state, primary_key: :state
  end
end
