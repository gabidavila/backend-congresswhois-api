class Api::V1::Congress::MembersController < ApplicationController
  def index
    render json: fetch
  end

  def senate
    render json: fetch('senate')
  end

  def house
    render json: fetch('house')
  end

  def show
    @member = CongressMember.find_by(id: params[:id])
    render json: @member
  end

  private

  def fetch(scope = 'order_name')
    limit = params[:limit] || 12

    party = params[:party]
    party = %w{R D I} if !params[:party] || params[:party] == 'A'

    name ||= params[:name]
    state ||= params[:state]
    scope = params[:congress] if params[:congress] && params[:congress] != ''

    if state == 'A'
      state = nil
    end

    @congress = CongressMember.includes(:state)
                  .where(party: party)
                  .where('state LIKE :state', state: "%#{state}%")
                  .where('full_name ILIKE :name', name: "%#{name}%")
                  .send(scope).limit(limit)
  end
end
