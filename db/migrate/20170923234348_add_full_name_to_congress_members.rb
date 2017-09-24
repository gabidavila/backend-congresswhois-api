class AddFullNameToCongressMembers < ActiveRecord::Migration[5.1]
  def change
    add_column :congress_members, :full_name, :string

    add_index :congress_members, :full_name
  end
end
