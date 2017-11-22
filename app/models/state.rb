class State < ApplicationRecord
  has_many :congress_members, foreign_key: :state, primary_key: :state
  has_many :cities, foreign_key: :state, primary_key: :state
  has_many :zipcodes, foreign_key: :state, primary_key: :state
  has_many :zipcodes_districts, foreign_key: :state, primary_key: :state

  def self.get_hashed_states
    State.all.map { |state| [state.state, state] }.to_h
  end
end
