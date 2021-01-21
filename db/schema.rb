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

ActiveRecord::Schema.define(version: 20210121095047) do

  create_table "assets", force: :cascade do |t|
    t.string   "description", limit: 255
    t.string   "emission",    limit: 255
    t.string   "entity",      limit: 255
    t.string   "scale",       limit: 255
    t.string   "supply",      limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "type",        limit: 255
    t.string   "typetx",      limit: 255
    t.string   "emissiontx",  limit: 255
  end

  create_table "blocks", force: :cascade do |t|
    t.integer  "chain_id",   limit: 4
    t.string   "blockid",    limit: 255
    t.integer  "height",     limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "time",       limit: 4
  end

  create_table "chains", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "chain",      limit: 255
    t.string   "dapp",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "block_id",   limit: 4
    t.string   "txid",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "chain_id",   limit: 4
    t.integer  "height",     limit: 4
    t.integer  "time",       limit: 4
  end

end
