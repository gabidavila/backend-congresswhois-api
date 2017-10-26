class CongressMember < ApplicationRecord
  paginates_per 12
  belongs_to :state, foreign_key: :state, primary_key: :state
  has_many :zipcodes_districts, -> (user) { unscope(where: :congress_member_id).where(zipcodes_districts: { state: user.state, district: user.district }) }

  scope :order_name, -> { order(:first_name).order(:last_name) }
  scope :order_lastname, -> { order(:last_name).order(:first_name) }
  scope :senate, -> { where(congress_type: :senate).order_name }
  scope :house, -> { where(congress_type: :house).order_name }
  scope :zipcodes, -> { joins("INNER JOIN zipcodes_districts ON (zipcodes_districts.state = congress_members.state AND zipcodes_districts.district = congress_members.district) OR (zipcodes_districts.state = congress_members.state AND congress_members.congress_type = 'senate')") }
end
