class Api::V1::Congress::ComparisonsController < ApplicationController
  def compare
    render json: {
      votes:    ProPublica::Congress::Comparisons.votes(params[:comparison]),
      bills:    ProPublica::Congress::Comparisons.bills(params[:comparison]),
      chamber:  params[:comparison][:chamber],
      congress: params[:comparison][:congress]
    }
  end
end