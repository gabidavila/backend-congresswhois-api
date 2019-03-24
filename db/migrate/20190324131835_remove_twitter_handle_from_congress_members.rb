class RemoveTwitterHandleFromCongressMembers < ActiveRecord::Migration[5.1]
  def change
    remove_columns :congress_members, :twitter_handle, :twitter_picture_url, :member_profile_response_api
  end
end
