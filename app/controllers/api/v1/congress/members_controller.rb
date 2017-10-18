class Api::V1::Congress::MembersController < ApplicationController
  def index
    fetch
    render json: @congress, meta: pagination_dict(@congress)
  end

  def senate
    render json: fetch('senate')
  end

  def house
    render json: fetch('house')
  end

  def show
    @member = CongressMember.find_by(pp_member_id: params[:id])
    render json: @member
  end

  private

  def fetch(scope = 'order_name')
    page = params[:page] || 1 if params[:page]
    page = page['number'] if !page.class != String

    party = params[:party]
    party = %w{R D I} if !params[:party] || params[:party] == 'A'

    name ||= params[:name]
    state ||= params[:state]
    scope = params[:congress] if params[:congress] && params[:congress] != ''

    if state == 'A'
      state = nil
    end

    @congress = CongressMember.includes(:state).where(party: party)
                  .where('state LIKE :state', state: "%#{state}%")
                  .where('full_name ILIKE :name', name: "%#{name}%")
                  .send(scope).page(page)
  end
end
