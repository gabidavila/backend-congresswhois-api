class Api::V1::Congress::MembersController < ApplicationController
  def index
    render json: fetch('order_name')
  end

  def senate
    render json: fetch('senate')
  end

  def house
    render json: fetch('house')
  end

  private

  def fetch(scope)
    limit = params[:limit] || 36

    party = params[:party]
    party = '%w R D I' if !params[:party] || params[:party] == 'A'

    name ||= params[:name]

    @congress = CongressMember.where(party: party).where('full_name ILIKE :name', name: "%#{name}%")
                  .send(scope).limit(limit)
  end
end
