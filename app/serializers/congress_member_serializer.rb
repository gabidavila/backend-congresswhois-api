class CongressMemberSerializer < ActiveModel::Serializer
  attributes :id, :congress_type, :congress, :first_name, :last_name, :phone, :party, :pp_member_id,
             :twitter_handle, :twitter_picture_url, :facebook, :pp_api_uri, :full_name, :next_election, :party, :propublica_profile, :career
  belongs_to :state

  def propublica_profile
    object.general_response_api
  end

  def career
    object.member_profile_response_api
  end

  def facebook
    propublica_profile['facebook_account']
  end

  def phone
    propublica_profile['phone']
  end

  def pp_api_uri
    propublica_profile['api_uri']
  end

  def next_election
    propublica_profile['next_election']
  end
end
