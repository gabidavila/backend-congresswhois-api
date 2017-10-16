class AddDistrictToCongressMembers < ActiveRecord::Migration[5.1]
  def change
    add_column :congress_members, :district, :string

    add_index :congress_members, :district
  end
end
