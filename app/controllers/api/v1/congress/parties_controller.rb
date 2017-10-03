class Api::V1::Congress::PartiesController < ApplicationController
  def representation
    house_representation = ProPublica::Congress::Parties.state_representation["house"]
    representation        = State.order(:state).pluck(:state).map do |state|
      parties = house_representation.find do |state_parties|
        state == state_parties.keys.first
      end
      sorted  = parties[state].sort_by do |object|
        object.values.first
      end if parties
      { name: state, main_party: sorted.last.keys.first, party_count: sorted } if parties
    end.compact

    render json: representation, status: 200
  end
end
