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

ActiveRecord::Schema.define(version: 20131205101158) do

  create_table "relationships", force: true do |t|
    t.integer  "parent_id"
    t.integer  "child_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["child_id"], name: "index_relationships_on_child_id"
  add_index "relationships", ["parent_id", "child_id"], name: "index_relationships_on_parent_id_and_child_id", unique: true
  add_index "relationships", ["parent_id"], name: "index_relationships_on_parent_id"

  create_table "tutorages", force: true do |t|
    t.integer  "volunteer_id"
    t.integer  "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "ID_num"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
    t.string   "type"
    t.string   "email"
    t.integer  "grade"
    t.string   "phone"
    t.string   "address"
    t.string   "interest"
    t.string   "specialization"
    t.string   "session"
    t.string   "note"
    t.string   "source"
  end

  add_index "users", ["ID_num"], name: "index_users_on_ID_num", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
