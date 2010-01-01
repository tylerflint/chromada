# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100101231128) do

  create_table "employees", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.integer  "increment_id",                             :default => 0
    t.string   "employee_id",               :limit => 20,  :default => ""
    t.string   "firstname",                 :limit => 20
    t.string   "lastname",                  :limit => 20
    t.string   "middlename",                :limit => 20,  :default => ""
    t.string   "prefix",                    :limit => 10,  :default => ""
    t.string   "suffix",                    :limit => 10,  :default => ""
    t.date     "birthdate"
    t.integer  "is_active",                                :default => 1
  end

  add_index "employees", ["login"], :name => "index_employees_on_login", :unique => true

end
