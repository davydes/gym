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

ActiveRecord::Schema.define(version: 20160524104339) do

  create_table "body_parts", force: :cascade do |t|
    t.string "alias",       null: false
    t.string "name",        null: false
    t.text   "description"
  end

  add_index "body_parts", ["alias"], name: "index_body_parts_on_alias", unique: true

  create_table "body_parts_exercises", id: false, force: :cascade do |t|
    t.integer "body_part_id"
    t.integer "exercise_id"
  end

  add_index "body_parts_exercises", ["body_part_id"], name: "index_body_parts_exercises_on_body_part_id"
  add_index "body_parts_exercises", ["exercise_id"], name: "index_body_parts_exercises_on_exercise_id"

  create_table "body_parts_muscles", id: false, force: :cascade do |t|
    t.integer "body_part_id"
    t.integer "muscle_id"
  end

  add_index "body_parts_muscles", ["body_part_id"], name: "index_body_parts_muscles_on_body_part_id"
  add_index "body_parts_muscles", ["muscle_id"], name: "index_body_parts_muscles_on_muscle_id"

  create_table "exercises", force: :cascade do |t|
    t.string   "alias",       null: false
    t.string   "name",        null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "exercises_muscles", id: false, force: :cascade do |t|
    t.integer "exercise_id"
    t.integer "muscle_id"
  end

  add_index "exercises_muscles", ["exercise_id"], name: "index_exercises_muscles_on_exercise_id"
  add_index "exercises_muscles", ["muscle_id"], name: "index_exercises_muscles_on_muscle_id"

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "accesstoken"
    t.string   "refreshtoken"
    t.string   "name"
    t.string   "email"
    t.string   "nickname"
    t.string   "image"
    t.string   "phone"
    t.string   "urls"
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id"

  create_table "muscles", force: :cascade do |t|
    t.string   "alias",       null: false
    t.string   "name",        null: false
    t.text     "description"
    t.string   "shape"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "muscles", ["alias"], name: "index_muscles_on_alias", unique: true

  create_table "picture_links", id: false, force: :cascade do |t|
    t.integer "picture_id"
    t.integer "pictureable_id"
    t.string  "pictureable_type"
  end

  add_index "picture_links", ["picture_id"], name: "index_picture_links_on_picture_id"
  add_index "picture_links", ["pictureable_id", "pictureable_type", "picture_id"], name: "pk_picture_links", unique: true

  create_table "pictures", force: :cascade do |t|
    t.string   "image"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "name"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                            default: "",    null: false
    t.string   "encrypted_password",               default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gender",                 limit: 1
    t.string   "country"
    t.string   "city"
    t.datetime "date_of_birth"
    t.boolean  "admin",                            default: false, null: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
