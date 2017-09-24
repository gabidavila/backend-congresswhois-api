class CreateCongressMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :congress_members do |t|
      t.integer :congress, null: false, default: 115
      t.string :congress_type, default: 'senate'
      t.string :first_name, null: false
      t.string :middle_name
      t.string :last_name, null: false
      t.string :pp_member_id, null: false
      t.string :twitter_handle
      t.text :twitter_picture_url
      t.string :party, length: 1, null: false
      t.string :state, length: 2, null: false
      t.jsonb :general_response_api, default: {}
      t.jsonb :member_profile_response_api, null: false, default: {}

      t.timestamps
    end

    add_index :congress_members, :state
    add_index :congress_members, :party
    add_index :congress_members, [:congress, :party]
  end
end
