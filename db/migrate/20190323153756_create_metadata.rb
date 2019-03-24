class CreateMetadata < ActiveRecord::Migration[5.1]
  def change
    create_table :metadata do |t|
      t.string :pp_member_id, null: false
      t.string :twitter_handle
      t.text :twitter_picture_url
      t.jsonb :recent_profile_object, default: {}

      t.timestamps
    end

    add_index :metadata, :pp_member_id, unique: true
  end
end
