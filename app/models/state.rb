class State < ApplicationRecord
  has_many :congress_members, foreign_key: :state, primary_key: :state
  has_many :cities, foreign_key: :state, primary_key: :state
  has_many :zipcodes, foreign_key: :state, primary_key: :state
end
