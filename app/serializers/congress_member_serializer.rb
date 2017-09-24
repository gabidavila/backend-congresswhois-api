class CongressMemberSerializer < ActiveModel::Serializer
  attributes :id, :congress_type, :congress, :first_name, :last_name, :phone, :party, :pp_member_id,
             :twitter_handle, :twitter_picture_url, :facebook, :pp_api_uri, :full_name, :next_election, :party
  belongs_to :state


  def response_api
    object.general_response_api
  end

  def facebook
    response_api['facebook_account']
  end

  def phone
    response_api['phone']
  end

  def pp_api_uri
    response_api['api_uri']
  end

  def next_election
    response_api['next_election']
  end
end
