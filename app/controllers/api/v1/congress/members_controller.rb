class Api::V1::Congress::MembersController < ApplicationController

  def index
    limit = params[:limit] || 12

    party = params[:party]
    party = ["R", "D", "I"] if !params[:party] || params[:party] == "A"

    @congress = CongressMember.where(party: party).order_name.limit(limit)
    render :json => @congress
  end

  def senate
    limit = params[:limit] || 12

    party = params[:party]
    party = ["R", "D", "I"] if !params[:party] || params[:party] == "A"

    @congress = CongressMember.where(party: party).senate.limit(limit)
    render :json => @congress
  end

  def house
    limit = params[:limit] || 12

    party = params[:party]
    party = ["R", "D", "I"] if !params[:party] || params[:party] == "A"

    @congress = CongressMember.where(party: party).house.limit(limit)
    render :json => @congress
  end
end
