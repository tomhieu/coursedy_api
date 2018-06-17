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

ActiveRecord::Schema.define(version: 20180617050921) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bigbluebutton_attendees", force: :cascade do |t|
    t.string "user_id"
    t.string "external_user_id"
    t.string "user_name"
    t.decimal "join_time", precision: 14
    t.decimal "left_time", precision: 14
    t.integer "bigbluebutton_meeting_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bigbluebutton_meetings", force: :cascade do |t|
    t.string "server_url"
    t.string "server_secret"
    t.integer "room_id"
    t.string "meetingid"
    t.string "name"
    t.decimal "create_time", precision: 14
    t.decimal "finish_time", precision: 14
    t.boolean "running", default: false
    t.boolean "recorded", default: false
    t.integer "creator_id"
    t.string "creator_name"
    t.boolean "ended", default: false
    t.string "got_stats"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meetingid", "create_time"], name: "index_bigbluebutton_meetings_on_meetingid_and_create_time", unique: true
  end

  create_table "bigbluebutton_metadata", force: :cascade do |t|
    t.integer "owner_id"
    t.string "owner_type"
    t.string "name"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bigbluebutton_playback_formats", force: :cascade do |t|
    t.integer "recording_id"
    t.integer "playback_type_id"
    t.string "url"
    t.integer "length"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bigbluebutton_playback_types", force: :cascade do |t|
    t.string "identifier"
    t.boolean "visible", default: false
    t.boolean "default", default: false
    t.boolean "downloadable", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bigbluebutton_recordings", force: :cascade do |t|
    t.integer "server_id"
    t.integer "room_id"
    t.integer "meeting_id"
    t.string "recordid"
    t.string "meetingid"
    t.string "name"
    t.boolean "published", default: false
    t.decimal "start_time", precision: 14
    t.decimal "end_time", precision: 14
    t.boolean "available", default: true
    t.string "description"
    t.bigint "size", default: 0
    t.text "recording_users"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recordid"], name: "index_bigbluebutton_recordings_on_recordid", unique: true
    t.index ["room_id"], name: "index_bigbluebutton_recordings_on_room_id"
  end

  create_table "bigbluebutton_room_options", force: :cascade do |t|
    t.integer "room_id"
    t.string "default_layout"
    t.boolean "presenter_share_only"
    t.boolean "auto_start_video"
    t.boolean "auto_start_audio"
    t.string "background"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_bigbluebutton_room_options_on_room_id"
  end

  create_table "bigbluebutton_rooms", force: :cascade do |t|
    t.integer "owner_id"
    t.string "owner_type"
    t.string "meetingid"
    t.string "name"
    t.string "attendee_key"
    t.string "moderator_key"
    t.string "welcome_msg"
    t.string "logout_url"
    t.string "voice_bridge"
    t.string "dial_number"
    t.integer "max_participants"
    t.boolean "private", default: false
    t.boolean "external", default: false
    t.string "slug"
    t.boolean "record_meeting", default: false
    t.integer "duration", default: 0
    t.string "attendee_api_password"
    t.string "moderator_api_password"
    t.decimal "create_time", precision: 14
    t.string "moderator_only_message"
    t.boolean "auto_start_recording", default: false
    t.boolean "allow_start_stop_recording", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meetingid"], name: "index_bigbluebutton_rooms_on_meetingid", unique: true
  end

  create_table "bigbluebutton_server_configs", force: :cascade do |t|
    t.integer "server_id"
    t.text "available_layouts"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bigbluebutton_servers", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.string "secret"
    t.string "version"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_categories_on_category_id"
  end

  create_table "categories_tutors", force: :cascade do |t|
    t.bigint "category_id"
    t.bigint "tutor_id"
    t.index ["category_id"], name: "index_categories_tutors_on_category_id"
    t.index ["tutor_id"], name: "index_categories_tutors_on_tutor_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.string "post_code"
    t.string "country"
    t.string "country_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "course_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "content"
    t.index ["course_id"], name: "index_comments_on_course_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "course_levels", force: :cascade do |t|
    t.integer "level"
    t.string "name"
    t.string "description"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_course_levels_on_category_id"
  end

  create_table "course_objectives", force: :cascade do |t|
    t.string "content"
    t.boolean "highlight"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_objectives_on_course_id"
  end

  create_table "course_ratings", force: :cascade do |t|
    t.bigint "course_id"
    t.bigint "user_id"
    t.integer "points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_ratings_on_course_id"
    t.index ["user_id"], name: "index_course_ratings_on_user_id"
  end

  create_table "course_sections", force: :cascade do |t|
    t.string "title"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_sections_on_course_id"
  end

  create_table "course_subscribers", force: :cascade do |t|
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["course_id"], name: "index_course_subscribers_on_course_id"
    t.index ["user_id"], name: "index_course_subscribers_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "start_date"
    t.bigint "user_id"
    t.boolean "is_public", default: false
    t.boolean "is_active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "period"
    t.integer "number_of_students"
    t.integer "tuition_fee"
    t.string "currency"
    t.string "cover_image"
    t.bigint "category_id"
    t.bigint "course_level_id"
    t.string "location"
    t.boolean "is_free", default: false
    t.bigint "city_id"
    t.bigint "district_id"
    t.integer "views", default: 0
    t.integer "status", default: 0
    t.integer "lesson_count", default: 0
    t.integer "rating_count", default: 0
    t.integer "rating_points", default: 0
    t.bigint "bigbluebutton_room_id"
    t.index ["bigbluebutton_room_id"], name: "index_courses_on_bigbluebutton_room_id"
    t.index ["category_id"], name: "index_courses_on_category_id"
    t.index ["city_id"], name: "index_courses_on_city_id"
    t.index ["course_level_id"], name: "index_courses_on_course_level_id"
    t.index ["district_id"], name: "index_courses_on_district_id"
    t.index ["user_id"], name: "index_courses_on_user_id"
  end

  create_table "degrees", force: :cascade do |t|
    t.bigint "user_id"
    t.string "item"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tutor_id"
    t.string "name"
    t.index ["tutor_id"], name: "index_degrees_on_tutor_id"
    t.index ["user_id"], name: "index_degrees_on_user_id"
  end

  create_table "districts", force: :cascade do |t|
    t.string "name"
    t.string "postcode"
    t.bigint "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["city_id"], name: "index_districts_on_city_id"
  end

  create_table "districts_tutors", force: :cascade do |t|
    t.bigint "district_id"
    t.bigint "tutor_id"
    t.index ["district_id"], name: "index_districts_tutors_on_district_id"
    t.index ["tutor_id"], name: "index_districts_tutors_on_tutor_id"
  end

  create_table "documents", force: :cascade do |t|
    t.string "item"
    t.bigint "lesson_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["lesson_id"], name: "index_documents_on_lesson_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.string "title"
    t.bigint "course_id"
    t.bigint "course_section_id"
    t.integer "period"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.boolean "published", default: false
    t.index ["course_id"], name: "index_lessons_on_course_id"
    t.index ["course_section_id"], name: "index_lessons_on_course_section_id"
  end

  create_table "participations", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_participations_on_course_id"
    t.index ["user_id"], name: "index_participations_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "time_slots", force: :cascade do |t|
    t.time "start_time"
    t.time "end_time"
    t.bigint "week_day_schedule_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["week_day_schedule_id"], name: "index_time_slots_on_week_day_schedule_id"
  end

  create_table "tutor_educations", force: :cascade do |t|
    t.string "title"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "graduated_from"
    t.string "description"
    t.bigint "tutor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tutor_id"], name: "index_tutor_educations_on_tutor_id"
  end

  create_table "tutor_ratings", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "course_id"
    t.integer "teacher_id"
    t.integer "points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_tutor_ratings_on_course_id"
    t.index ["user_id"], name: "index_tutor_ratings_on_user_id"
  end

  create_table "tutor_reviews", force: :cascade do |t|
    t.string "content"
    t.bigint "user_id"
    t.integer "teacher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_tutor_reviews_on_user_id"
  end

  create_table "tutor_work_experiences", force: :cascade do |t|
    t.string "title"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "company"
    t.string "description"
    t.bigint "tutor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tutor_id"], name: "index_tutor_work_experiences_on_tutor_id"
  end

  create_table "tutors", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "hour_rate"
    t.string "highest_education"
    t.boolean "teach_online", default: false
    t.string "currency"
    t.string "place_of_work"
    t.index ["user_id"], name: "index_tutors_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone_number"
    t.string "role"
    t.string "address"
    t.datetime "date_of_birth"
    t.string "gender"
    t.string "avatar"
    t.string "avatar_name"
    t.integer "rating_count", default: 0
    t.integer "rating_points", default: 0
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  create_table "week_day_schedules", force: :cascade do |t|
    t.integer "day"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.index ["course_id"], name: "index_week_day_schedules_on_course_id"
  end

  add_foreign_key "categories_tutors", "categories"
  add_foreign_key "categories_tutors", "tutors"
  add_foreign_key "comments", "courses"
  add_foreign_key "comments", "users"
  add_foreign_key "course_levels", "categories"
  add_foreign_key "course_ratings", "courses"
  add_foreign_key "course_ratings", "users"
  add_foreign_key "course_sections", "courses"
  add_foreign_key "course_subscribers", "courses"
  add_foreign_key "course_subscribers", "users"
  add_foreign_key "courses", "bigbluebutton_rooms"
  add_foreign_key "courses", "categories"
  add_foreign_key "courses", "cities"
  add_foreign_key "courses", "course_levels"
  add_foreign_key "courses", "districts"
  add_foreign_key "courses", "users"
  add_foreign_key "degrees", "users"
  add_foreign_key "districts", "cities"
  add_foreign_key "districts_tutors", "districts"
  add_foreign_key "districts_tutors", "tutors"
  add_foreign_key "documents", "lessons"
  add_foreign_key "lessons", "course_sections"
  add_foreign_key "lessons", "courses"
  add_foreign_key "participations", "courses"
  add_foreign_key "participations", "users"
  add_foreign_key "time_slots", "week_day_schedules"
  add_foreign_key "tutor_educations", "tutors"
  add_foreign_key "tutor_ratings", "courses"
  add_foreign_key "tutor_ratings", "users"
  add_foreign_key "tutor_reviews", "users"
  add_foreign_key "tutor_work_experiences", "tutors"
  add_foreign_key "week_day_schedules", "courses"
end
