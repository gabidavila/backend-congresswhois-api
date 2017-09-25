require 'csv'

def get_states
  all = State.all
  all.map{|state| [state.state , state]}.to_h
end

namespace :seed do
  desc 'Import States'
  task _01_import_us_states: :environment do
    filename = File.join(Rails.root, 'db', 'import', 'us_states_and_territories.csv')
    states   = []
    CSV.foreach(filename, headers: true, header_converters: :symbol, col_sep: "\t") do |row|
      states << { state: row[:state], state_full: row[:state_full] }
    end
    State.create(states)
  end

  desc 'Initial Import for the Senate'
  task _02_initial_import_members_senate: :environment do
    members        = ProPublica::Congress::Senate.members
    mapped_members = members.map do |member|
      {
        congress_type:        'senate',
        first_name:           member['first_name'],
        middle_name:          member['middle_name'],
        last_name:            member['last_name'],
        pp_member_id:         member['id'],
        twitter_handle:       member['twitter_account'],
        party:                member['party'],
        state:                State.find_by(state: member['state']),
        general_response_api: member
      }
    end
    CongressMember.create(mapped_members)
  end

  desc 'Initial Import for the House'
  task _03_initial_import_members_house: :environment do
    members        = ProPublica::Congress::House.members
    mapped_members = members.map do |member|
      {
        congress_type:        'house',
        first_name:           member['first_name'],
        middle_name:          member['middle_name'],
        last_name:            member['last_name'],
        pp_member_id:         member['id'],
        twitter_handle:       member['twitter_account'],
        party:                member['party'],
        state:                State.find_by(state: member['state']),
        general_response_api: member
      }
    end
    CongressMember.create(mapped_members)
  end

  desc 'Add full_name to congressmen'
  task _04_add_full_name_to_congress_members: :environment do
    members = CongressMember.all
    members.each do |member|
      full_name = "#{member.first_name} #{member.last_name}"

      if member.middle_name
        full_name = "#{member.first_name} #{member.middle_name} #{member.last_name}"
      end

      member.update(full_name: full_name)
    end
  end

  desc 'Twitter Image Import'
  task _05_twitter_image_profile_congressman: :environment do
    congressmen       = CongressMember.where.not(twitter_handle: nil).where(twitter_picture_url: nil)
    propublica_config = Rails.application.config.propublica
    client            = Twitter::REST::Client.new do |config|
      config.consumer_key        = propublica_config[:twitter][:consumer_key]
      config.consumer_secret     = propublica_config[:twitter][:consumer_secret]
      config.access_token        = propublica_config[:twitter][:access_token]
      config.access_token_secret = propublica_config[:twitter][:access_token_secret]
    end
    congressmen.each do |congressman|
      begin
        user      = client.user(congressman[:twitter_handle])
        image_url = user.profile_image_uri.to_s.gsub('_normal', '')
        congressman.update(twitter_picture_url: image_url)
      rescue Twitter::Error::NotFound => e
        puts e
      end
    end
  end

  desc 'Import Cities'
  task _06_import_us_cities: :environment do
    states = get_states
    filename = File.join(Rails.root, 'db', 'import', 'us_cities_states_counties.csv')
    cities   = []

    CSV.foreach(filename, headers: true, header_converters: :symbol, col_sep: '|') do |row|
      city = {
        city:       row[:city],
        state:      states[row[:state_short]],
        county:     row[:county],
        city_alias: row[:city_alias]
      }
      cities << city
    end
    City.create(cities)
  end

  desc 'Import Zipcodes'
  task _07_import_us_zipcodes: :environment do
    states = get_states
    filename = File.join(Rails.root, 'db', 'import', 'us_zipcodes_data.csv')
    zipcodes = []
    CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
      zipcode = {
        zipcode:       row[:zipcode],
        zipcode_type:  row[:zipcodetype],
        city:          row[:city],
        state:         states[row[:state]],
        location_type: row[:locationtype],
        latitude:      row[:lat],
        longitude:     row[:long],
        world_region:  row[:worldregion],
        country:       row[:country],
        location_text: row[:locationtext]
      }
      zipcodes << zipcode
    end
    Zipcode.create(zipcodes)
  end
end
