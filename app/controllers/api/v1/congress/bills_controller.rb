class Api::V1::Congress::BillsController < ApplicationController
  def index
    render json: ProPublica::Congress::Bills.recent(params[:offset])['results'].first
  end

  def show
    bill = ProPublica::Congress::Bills.item(params[:id], params[:congress_id])['results'].first
    member = CongressMember.find_by(pp_member_id: bill['sponsor_id'], congress: params[:congress_id])
    metadata = Metadata.find_by(pp_member_id: bill['sponsor_id'])

    response = {
        bill: bill,
        member: member,
        metadata: metadata
    }
    render json: response, status: 200
  end
end
