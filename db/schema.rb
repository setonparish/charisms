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

ActiveRecord::Schema.define(version: 2018_12_13_205943) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "charism_opportunities", force: :cascade do |t|
    t.bigint "charism_id"
    t.bigint "opportunity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["charism_id"], name: "index_charism_opportunities_on_charism_id"
    t.index ["opportunity_id"], name: "index_charism_opportunities_on_opportunity_id"
  end

  create_table "charism_scores", force: :cascade do |t|
    t.bigint "survey_response_id"
    t.bigint "charism_id"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "max_score", default: 0
    t.index ["charism_id"], name: "index_charism_scores_on_charism_id"
    t.index ["survey_response_id"], name: "index_charism_scores_on_survey_response_id"
  end

  create_table "charisms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
  end

  create_table "opportunities", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_opportunities_on_organization_id"
  end

  create_table "organization_memberships", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organization_id"
    t.index ["organization_id"], name: "index_organization_memberships_on_organization_id"
    t.index ["user_id"], name: "index_organization_memberships_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "question_orders", force: :cascade do |t|
    t.bigint "survey_id"
    t.bigint "question_id"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_question_orders_on_question_id"
    t.index ["survey_id"], name: "index_question_orders_on_survey_id"
  end

  create_table "question_responses", force: :cascade do |t|
    t.bigint "survey_response_id"
    t.bigint "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
    t.integer "answer"
    t.index ["question_id"], name: "index_question_responses_on_question_id"
    t.index ["survey_response_id"], name: "index_question_responses_on_survey_response_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "charism_id"
    t.index ["charism_id"], name: "index_questions_on_charism_id"
  end

  create_table "respondents", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.boolean "site_admin", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "survey_responses", force: :cascade do |t|
    t.string "slug"
    t.bigint "survey_id"
    t.bigint "respondent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "web_link_id"
    t.index ["respondent_id"], name: "index_survey_responses_on_respondent_id"
    t.index ["slug"], name: "index_survey_responses_on_slug"
    t.index ["survey_id"], name: "index_survey_responses_on_survey_id"
    t.index ["web_link_id"], name: "index_survey_responses_on_web_link_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "web_links", force: :cascade do |t|
    t.string "name"
    t.bigint "survey_id"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organization_id"
    t.index ["organization_id"], name: "index_web_links_on_organization_id"
    t.index ["survey_id"], name: "index_web_links_on_survey_id"
  end

  add_foreign_key "charism_opportunities", "charisms"
  add_foreign_key "charism_opportunities", "opportunities"
  add_foreign_key "charism_scores", "charisms"
  add_foreign_key "charism_scores", "survey_responses"
  add_foreign_key "organization_memberships", "organizations"
  add_foreign_key "organization_memberships", "users"
  add_foreign_key "question_orders", "questions"
  add_foreign_key "question_orders", "surveys"
  add_foreign_key "question_responses", "questions"
  add_foreign_key "question_responses", "survey_responses"
  add_foreign_key "survey_responses", "respondents"
  add_foreign_key "survey_responses", "surveys"
  add_foreign_key "survey_responses", "web_links"
  add_foreign_key "web_links", "surveys"
end
