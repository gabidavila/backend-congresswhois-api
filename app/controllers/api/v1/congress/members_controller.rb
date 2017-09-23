class Api::V1::Congress::MembersController < ApplicationController

  def index
    render :json => fetch("order_name")
  end

  def senate
    render :json => fetch("senate")
  end

  def house
    render :json => fetch("house")
  end

  private

  def fetch(scope)
    limit = params[:limit] || 12

    party = params[:party]
    party = ["R", "D", "I"] if !params[:party] || params[:party] == "A"

    @congress = CongressMember.where(party: party).send(scope).limit(limit)
  end
end
