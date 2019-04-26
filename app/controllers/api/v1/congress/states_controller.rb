class Api::V1::Congress::StatesController < ApplicationController
  def index
    render json: State.order(:state_full)
  end
end
