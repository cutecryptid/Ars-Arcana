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

ActiveRecord::Schema.define(version: 20150922175406) do

  create_table "arcana_fusion_threes", force: :cascade do |t|
    t.integer  "arcana1_id"
    t.integer  "arcana2_id"
    t.integer  "arcana3_id"
    t.integer  "result_arcana_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "arcana_fusion_threes", ["result_arcana_id", "arcana1_id", "arcana2_id"], name: "index_result_arcana_threes"

  create_table "arcana_fusion_twos", force: :cascade do |t|
    t.integer  "arcana1_id"
    t.integer  "arcana2_id"
    t.integer  "result_arcana_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "arcana_fusion_twos", ["result_arcana_id", "arcana1_id", "arcana2_id"], name: "index_result_arcana"

  create_table "arcanas", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "number"
    t.integer  "IntNumber"
    t.string   "slug"
  end

  add_index "arcanas", ["slug"], name: "index_arcanas_on_slug", unique: true

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "personas", force: :cascade do |t|
    t.string   "name"
    t.integer  "base_level"
    t.integer  "arcana_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
    t.boolean  "max"
    t.boolean  "special"
  end

  add_index "personas", ["slug"], name: "index_personas_on_slug", unique: true

# Could not dump table "special_fusions" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

end
