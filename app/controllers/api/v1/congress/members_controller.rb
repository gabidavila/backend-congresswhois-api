class Api::V1::Congress::MembersController < ApplicationController
  extend ProPublica::Connection

  def index
    binding.pry
  end
end
