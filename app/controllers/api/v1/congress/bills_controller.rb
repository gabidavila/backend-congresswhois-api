class Api::V1::Congress::BillsController < ApplicationController
  def index
    render json: ProPublica::Congress::Bills.recent(params[:offset])['results'].first
  end
end
