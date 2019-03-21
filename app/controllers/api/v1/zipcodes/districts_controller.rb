class Api::V1::Zipcodes::DistrictsController < ApplicationController
  def search
    members = CongressMember.zipcodes.where(zipcodes_districts: {zipcode: params['zipcode']}).where(congress: ProPublica::Congress.current).page(1)
    render json: members, meta: pagination_dict(members)
  end
end
