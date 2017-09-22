class CongressMemberApi < ActiveRestClient::Base
  base_url Rails.application.config.propublica[:api_base_url]

  def self.senate_number(senate = nil)
    senate || Rails.application.config.propublica[:congress][:current_senate]
  end

  def self.house_number(number = nil)
    number || Rails.application.config.propublica[:congress][:current_senate]
  end

  get :all_senate, "/#{senate_number}/senate/members.json"
end
