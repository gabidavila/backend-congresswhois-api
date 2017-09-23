class CongressMemberSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :phone, :state, :party, :pp_member_id, :twitter_handle, :twitter_picture_url, :facebook, :pp_api_uri

  def response_api
    object.general_response_api
  end

  def facebook
    response_api["facebook_account"]
  end

  def phone
    response_api["phone"]
  end

  def pp_api_uri
    response_api["api_uri"]
  end
end
