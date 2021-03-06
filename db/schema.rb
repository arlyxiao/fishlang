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

ActiveRecord::Schema.define(:version => 20130721012447) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "lesson_points", :force => true do |t|
    t.integer  "user_id"
    t.integer  "lesson_id"
    t.integer  "points",     :default => 0, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "lessons", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "category_id"
  end

  create_table "practice_points", :force => true do |t|
    t.integer  "user_id"
    t.integer  "practice_id"
    t.integer  "points",      :default => 0, :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "practices", :force => true do |t|
    t.integer  "lesson_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sentence_failure_points", :force => true do |t|
    t.integer  "user_id"
    t.integer  "points",     :default => 0, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "sentence_failures", :force => true do |t|
    t.integer  "sentence_id"
    t.integer  "user_id"
    t.integer  "count",         :default => 0, :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "correct_count", :default => 0, :null => false
  end

  create_table "sentence_reports", :force => true do |t|
    t.integer  "sentence_id"
    t.integer  "user_id"
    t.string   "user_answer"
    t.text     "content"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "sentence_translations", :force => true do |t|
    t.string   "subject"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "sentence_id"
  end

  create_table "sentences", :force => true do |t|
    t.string   "subject"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "practice_id"
    t.string   "verb"
    t.integer  "verb_tense_id", :default => 0, :null => false
  end

  create_table "user_exercises", :force => true do |t|
    t.integer  "user_id"
    t.string   "exam"
    t.string   "done_exam"
    t.integer  "error_count", :default => 0, :null => false
    t.integer  "done_count",  :default => 0, :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "kind"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "name"
    t.boolean  "admin",                  :default => false
    t.integer  "points",                 :default => 0,     :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "verb_tenses", :force => true do |t|
    t.string   "name"
    t.integer  "lesson_id"
    t.string   "yo"
    t.string   "tu"
    t.string   "el"
    t.string   "ella"
    t.string   "usted"
    t.string   "nosotros"
    t.string   "nosotras"
    t.string   "vosotros"
    t.string   "vosotras"
    t.string   "ellos"
    t.string   "ellas"
    t.string   "ustedes"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
