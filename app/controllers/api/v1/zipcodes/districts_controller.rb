class Api::V1::Zipcodes::DistrictsController < ApplicationController
  def search
    members = CongressMember.zipcodes.where(zipcodes_districts: {zipcode: params['zipcode']}).page(1)
    render json: members, meta: pagination_dict(members)
  end
end
