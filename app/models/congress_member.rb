class CongressMember < ApplicationRecord
  paginates_per 12
  belongs_to :state, foreign_key: :state, primary_key: :state

  scope :order_name, -> { order(:last_name).order(:first_name) }
  scope :senate, -> { where(congress_type: :senate).order_name }
  scope :house, -> { where(congress_type: :house).order_name }
end
