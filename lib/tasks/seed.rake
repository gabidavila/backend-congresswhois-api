namespace :seed do
  desc "Initial Import for the Senate"
  task initial_import_members_senate: :environment do
    members = ProPublica::Congress::Senate.members
    mapped_members = members.map do |member|
      {
        :congress_type => "senate",
        :first_name => member["first_name"],
        :middle_name => member["middle_name"],
        :last_name => member["last_name"],
        :pp_member_id => member["id"],
        :twitter_handle => member["twitter_account"],
        :party => member["party"],
        :state => member["state"],
        :general_response_api => member
      }
    end
    CongressMember.create(mapped_members)
  end

  task initial_import_members_house: :environment do
    members = ProPublica::Congress::House.members
    mapped_members = members.map do |member|
      {
        :congress_type => "house",
        :first_name => member["first_name"],
        :middle_name => member["middle_name"],
        :last_name => member["last_name"],
        :pp_member_id => member["id"],
        :twitter_handle => member["twitter_account"],
        :party => member["party"],
        :state => member["state"],
        :general_response_api => member
      }
    end
    CongressMember.create(mapped_members)
  end
end
