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

ActiveRecord::Schema.define(version: 20140303005714) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dribbbles", force: true do |t|
    t.integer  "employee_id"
    t.string   "username"
    t.integer  "shots_count"
    t.integer  "likes_count"
    t.integer  "likes_received_count"
    t.integer  "rebounds_count"
    t.string   "rebounds_received_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dribbbles", ["employee_id"], name: "index_dribbbles_on_employee_id", using: :btree

  create_table "educations", force: true do |t|
    t.integer  "linked_in_id"
    t.string   "degree"
    t.date     "end_date"
    t.date     "start_date"
    t.string   "field_of_study"
    t.string   "school_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "educations", ["linked_in_id"], name: "index_educations_on_linked_in_id", using: :btree

  create_table "employees", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "git_account"
    t.integer  "stack_overflow_account"
  end

  create_table "employers", force: true do |t|
    t.string   "company"
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "github_accounts", force: true do |t|
    t.integer  "employee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "username"
    t.string   "oauth_token"
  end

  add_index "github_accounts", ["employee_id"], name: "index_github_accounts_on_employee_id", using: :btree

  create_table "github_repos", force: true do |t|
    t.integer  "github_account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "Ruby"
    t.integer  "CSS"
    t.integer  "JavaScript"
    t.integer  "CoffeeScript"
    t.integer  "PHP"
    t.integer  "Java"
    t.integer  "Python"
    t.integer  "C"
    t.integer  "Shell"
    t.integer  "Perl"
    t.integer  "VimL"
    t.integer  "Scala"
    t.integer  "Go"
    t.integer  "Prolog"
    t.integer  "Clojure"
    t.integer  "Haskell"
    t.integer  "Lua"
  end

  add_index "github_repos", ["github_account_id"], name: "index_github_repos_on_github_account_id", using: :btree

  create_table "linked_ins", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "headline"
    t.string   "industry"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "summary"
    t.text     "interests"
    t.string   "languages"
    t.text     "skills"
    t.string   "location"
  end

  create_table "positions", force: true do |t|
    t.string   "title"
    t.text     "summary"
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "is_current"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "linked_in_id"
  end

  add_index "positions", ["linked_in_id"], name: "index_positions_on_linked_in_id", using: :btree

  create_table "stack_overflow_accounts", force: true do |t|
    t.integer  "employee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "reputation"
    t.integer  "age"
    t.integer  "badge_counts"
  end

  add_index "stack_overflow_accounts", ["employee_id"], name: "index_stack_overflow_accounts_on_employee_id", using: :btree

  create_table "stack_tags", force: true do |t|
    t.integer  "stack_overflow_account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "top_tag_name"
    t.integer  "question_score"
    t.integer  "question_count"
    t.integer  "answer_score"
    t.integer  "answer_count"
  end

  add_index "stack_tags", ["stack_overflow_account_id"], name: "index_stack_tags_on_stack_overflow_account_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "lastname"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
