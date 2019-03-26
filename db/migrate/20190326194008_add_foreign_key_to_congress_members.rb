class AddForeignKeyToCongressMembers < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :congress_members, :metadata, column: :pp_member_id, primary_key: :pp_member_id
  end
end
