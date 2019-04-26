class CongressMemberSerializer < ActiveModel::Serializer
  attributes :id, :congress_type, :congress, :first_name, :last_name, :phone, :party, :pp_member_id,
             :twitter_handle, :twitter_picture_url, :facebook, :pp_api_uri, :full_name, :next_election, :party,
             :propublica_profile, :career, :state, :district

  def propublica_profile
    object.general_response_api
  end

  def career
    object.metadata.recent_profile_object
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

  def state
    {
      state:      object.state.state,
      state_full: object.state.state_full
    }
  end

  def twitter_handle
    object.metadata[:twitter_handle]
  end

  def twitter_picture_url
    object.metadata[:twitter_picture_url]
  end
end
