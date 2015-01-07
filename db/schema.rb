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

ActiveRecord::Schema.define(version: 20150107082211) do

  create_table "blood_pressures", force: true do |t|
    t.integer  "member_id"
    t.integer  "diastolic"
    t.integer  "systolic"
    t.integer  "pulse"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blood_sugars", force: true do |t|
    t.integer  "test_type"
    t.float    "result"
    t.integer  "member_id"
    t.datetime "measure_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "body_temperatures", force: true do |t|
    t.float    "result"
    t.integer  "member_id"
    t.datetime "measure_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "category_items", force: true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.string   "item_tag"
    t.integer  "definition_type"
    t.integer  "result_type"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cholesterins", force: true do |t|
    t.integer  "test_type"
    t.float    "result"
    t.integer  "member_id"
    t.datetime "measure_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "doctor_communicate_members", force: true do |t|
    t.integer  "doctor_id"
    t.integer  "member_id"
    t.text     "msg"
    t.string   "sending"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "doctors", force: true do |t|
    t.string   "name"
    t.string   "password_digest"
    t.string   "avatar"
    t.string   "tel"
    t.string   "sex"
    t.text     "introduce"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", force: true do |t|
    t.string   "name"
    t.string   "password_digest"
    t.string   "avatar"
    t.string   "tel"
    t.string   "sex"
    t.integer  "doctor_id"
    t.date     "birthday"
    t.text     "health"
    t.string   "building"
    t.string   "unit"
    t.string   "house"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phy_exam_stand_results", force: true do |t|
    t.string   "name"
    t.integer  "phy_exam_tpl_item_id"
    t.integer  "definition_type"
    t.string   "unit"
    t.string   "device"
    t.integer  "result_type_id"
    t.integer  "normal_max"
    t.integer  "normal_min"
    t.string   "description"
    t.text     "result_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phy_exam_tpl_items", force: true do |t|
    t.integer  "phy_exam_tpl_id"
    t.integer  "category_item_id"
    t.string   "alias_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phy_exam_tpls", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "agency"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "purine_triones", force: true do |t|
    t.integer  "test_type"
    t.float    "result"
    t.integer  "member_id"
    t.datetime "measure_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "result_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
