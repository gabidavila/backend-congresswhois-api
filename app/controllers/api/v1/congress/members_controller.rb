class Api::V1::Congress::MembersController < ApplicationController
  def index
    fetch

    if params[:paginated] != 'false'
      render json: @congress, meta: pagination_dict(@congress)
    else
      render json: @congress
    end
  end

  def senate
    render json: fetch('senate', 'PROPUBLICA_CURRENT_SENATE')
  end

  def house
    render json: fetch('house', 'PROPUBLICA_CURRENT_HOUSE')
  end

  def show
    @member = CongressMember.find_by(pp_member_id: params[:id])
    render json: @member
  end

  private

  def fetch(scope = 'order_lastname', congress = '116')
    page = params[:page] || 1
    page = page['number'] if !page.class != String

    party = params[:party]
    party = %w{R D I} if !params[:party] || params[:party] == 'A'

    name  ||= params[:name]
    state ||= params[:state]
    congress = params[:congress] if params[:congress] && params[:congress] != ''

    if state == 'A'
      state = nil
    end

    if params[:paginated] == 'false'
      @congress = CongressMember.includes(:state).where(party: party)
                    .where('state LIKE :state', state: "%#{state}%")
                    .where('congress', ENV[congress])
                    .where('full_name ILIKE :name', name: "%#{name}%")
                    .send(scope)
    else
      @congress = CongressMember.includes(:state).where(party: party)
                    .where('state LIKE :state', state: "%#{state}%")
                    .where('congress', ENV[congress])
                    .where('full_name ILIKE :name', name: "%#{name}%")
                    .send(scope).page(page)
    end
  end
end
