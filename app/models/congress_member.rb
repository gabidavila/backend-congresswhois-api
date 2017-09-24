class CongressMember < ApplicationRecord
  scope :order_name, -> { order(:last_name).order(:first_name) }
  scope :senate, -> { where(congress_type: :senate).order_name }
  scope :house, -> { where(congress_type: :house).order_name }
end
