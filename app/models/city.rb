class City < ApplicationRecord
  belongs_to :state, foreign_key: :state, primary_key: :state
end
