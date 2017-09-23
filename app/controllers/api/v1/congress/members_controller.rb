class Api::V1::Congress::MembersController < ApplicationController

  def index
    @congress = CongressMember.order_name
    render :json => @congress
  end

  def senate
    @congress = CongressMember.senate
    render :json => @congress
  end

  def house
    @congress = CongressMember.house
    render :json => @congress
  end
end
