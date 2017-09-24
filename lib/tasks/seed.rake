# frozen_string_literal: true

namespace :seed do
  desc 'Initial Import for the Senate'
  task initial_import_members_senate: :environment do
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
        state:                member['state'],
        general_response_api: member
      }
    end
    CongressMember.create(mapped_members)
  end

  desc 'Initial Import for the House'
  task initial_import_members_house: :environment do
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
        state:                member['state'],
        general_response_api: member
      }
    end
    CongressMember.create(mapped_members)
  end

  desc 'Add full_name to congressmen'
  task add_full_name_to_congress_members: :environment do
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
  task twitter_image_profile_congressman: :environment do
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

  desc 'Import States'
  task import_us_states: :environment do
  end
end
