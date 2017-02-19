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

ActiveRecord::Schema.define(version: 20170219040057) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password_digest"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "issues", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "admin_id"
    t.string   "title"
    t.text     "description"
    t.integer  "category"
    t.integer  "severity"
    t.boolean  "resolved",    default: false
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["admin_id"], name: "index_issues_on_admin_id", using: :btree
    t.index ["user_id"], name: "index_issues_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.integer  "uuid"
    t.string   "token"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
