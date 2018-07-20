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

ActiveRecord::Schema.define(version: 2018_07_19_230551) do

  create_table "availabilities", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "shift_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shift_id"], name: "index_availabilities_on_shift_id"
    t.index ["user_id"], name: "index_availabilities_on_user_id"
  end

  create_table "events", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "title"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "teams_id"
    t.bigint "user_id"
    t.index ["teams_id"], name: "index_events_on_teams_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "requirements", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "shift_id"
    t.integer "mandatory"
    t.integer "optional"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "event_id"
    t.bigint "team_id"
    t.index ["event_id"], name: "index_requirements_on_event_id"
    t.index ["shift_id"], name: "index_requirements_on_shift_id"
    t.index ["team_id"], name: "index_requirements_on_team_id"
  end

  create_table "schedules", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "shift_id"
    t.bigint "team_id"
    t.bigint "event_id"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_schedules_on_event_id"
    t.index ["shift_id"], name: "index_schedules_on_shift_id"
    t.index ["team_id"], name: "index_schedules_on_team_id"
    t.index ["user_id"], name: "index_schedules_on_user_id"
  end

  create_table "shifts", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.bigint "event_id"
    t.bigint "users_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_shifts_on_event_id"
    t.index ["users_id"], name: "index_shifts_on_users_id"
  end

  create_table "teams", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "event_id"
    t.index ["event_id"], name: "index_teams_on_event_id"
    t.index ["user_id"], name: "index_teams_on_user_id"
  end

  create_table "teams_applications", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "team_id"
    t.integer "priority"
    t.index ["event_id"], name: "index_teams_applications_on_event_id"
    t.index ["team_id"], name: "index_teams_applications_on_team_id"
    t.index ["user_id"], name: "index_teams_applications_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "number", null: false
    t.date "birthday"
    t.string "email", default: "", null: false
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
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "availabilities", "shifts"
  add_foreign_key "availabilities", "users"
  add_foreign_key "events", "teams", column: "teams_id"
  add_foreign_key "events", "users"
  add_foreign_key "requirements", "events"
  add_foreign_key "requirements", "shifts"
  add_foreign_key "requirements", "teams"
  add_foreign_key "schedules", "events"
  add_foreign_key "schedules", "shifts"
  add_foreign_key "schedules", "teams"
  add_foreign_key "schedules", "users"
  add_foreign_key "shifts", "events"
  add_foreign_key "shifts", "users", column: "users_id"
  add_foreign_key "teams", "events"
  add_foreign_key "teams_applications", "teams"
end
