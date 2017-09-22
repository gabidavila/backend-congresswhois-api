# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170922183415) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "congress_members", force: :cascade do |t|
    t.integer "congress", default: 115, null: false
    t.string "congress_type", default: "senate"
    t.string "first_name", null: false
    t.string "middle_name"
    t.string "last_name", null: false
    t.string "pp_member_id", null: false
    t.string "twitter_handle"
    t.text "twitter_picture_url"
    t.string "party", null: false
    t.string "state", null: false
    t.jsonb "general_response_api", default: {}
    t.jsonb "member_profile_response_api", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
