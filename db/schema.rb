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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111127161948) do

  create_table "jobs", :force => true do |t|
    t.integer  "user_id"
    t.integer  "supervisor_id"
    t.string   "name"
    t.decimal  "rate",          :precision => 8, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "jobs", ["supervisor_id"], :name => "index_jobs_on_supervisor_id"
  add_index "jobs", ["user_id", "name"], :name => "index_jobs_on_user_id_and_name", :unique => true

  create_table "pay_periods", :force => true do |t|
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pay_periods", ["end_date"], :name => "index_pay_periods_on_end_date", :unique => true

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "user_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",              :default => false
    t.boolean  "supervisor",         :default => false
  end

  add_index "users", ["user_name"], :name => "index_users_on_user_name", :unique => true

end
