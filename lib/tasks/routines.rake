namespace :routines do
  desc 'Updates the current congress information'
  task update_members: :environment do
    Rake::Task['seed:_02_initial_import_members_senate'].invoke
    Rake::Task['seed:_03_initial_import_members_house'].invoke
    Rake::Task['seed:_04_add_full_name_to_congress_members'].invoke
    Rake::Task['seed:_05_twitter_image_profile_congressman'].invoke
    Rake::Task['seed:_08_import_members_profiles'].invoke
    Rake::Task['seed:_10_update_district_house'].invoke
  end
end
