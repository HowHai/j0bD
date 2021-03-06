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

ActiveRecord::Schema.define(version: 20140308230623) do

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
    t.string   "name"
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

  create_table "favorites", force: true do |t|
    t.integer  "employee_id"
    t.integer  "employer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorites", ["employee_id"], name: "index_favorites_on_employee_id", using: :btree
  add_index "favorites", ["employer_id"], name: "index_favorites_on_employer_id", using: :btree

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
    t.integer  "employee_id"
    t.integer  "employer_id"
  end

  add_index "linked_ins", ["employee_id"], name: "index_linked_ins_on_employee_id", using: :btree
  add_index "linked_ins", ["employer_id"], name: "index_linked_ins_on_employer_id", using: :btree

  create_table "positions", force: true do |t|
    t.string   "title"
    t.text     "summary"
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "is_current"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "linked_in_id"
    t.string   "company_name"
  end

  add_index "positions", ["linked_in_id"], name: "index_positions_on_linked_in_id", using: :btree

  create_table "primary_stats", force: true do |t|
    t.integer  "employee_id"
    t.integer  "ruby"
    t.integer  "css"
    t.integer  "javascript"
    t.integer  "coffeescript"
    t.integer  "php"
    t.integer  "java"
    t.integer  "python"
    t.integer  "c"
    t.integer  "shell"
    t.integer  "perl"
    t.integer  "vimL"
    t.integer  "scala"
    t.integer  "go"
    t.integer  "prolog"
    t.integer  "clojure"
    t.integer  "haskell"
    t.integer  "lua"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "primary_stats", ["employee_id"], name: "index_primary_stats_on_employee_id", using: :btree

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

end
