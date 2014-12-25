# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141220000429) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assignments", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.date     "due_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grading_fields", force: true do |t|
    t.string   "name"
    t.integer  "category"
    t.text     "comment"
    t.integer  "rubric_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rubrics", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "studios", force: true do |t|
    t.string   "name"
    t.integer  "ta_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "submissions", force: true do |t|
    t.integer  "student_id"
    t.integer  "assignment_id"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "name"
    t.integer  "studio_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",            null: false
    t.string   "name",             null: false
    t.string   "type"
    t.string   "pid",              null: false
    t.string   "crypted_password", null: false
    t.string   "salt",             null: false
    t.integer  "studio_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
