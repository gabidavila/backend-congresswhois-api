class Api::V1::Congress::ComparisonsController < ApplicationController
  def compare
    render json: {
      votes: ProPublica::Congress::Comparisons.votes(params[:comparison]),
      bills: ProPublica::Congress::Comparisons.bills(params[:comparison])
    }
  end
end