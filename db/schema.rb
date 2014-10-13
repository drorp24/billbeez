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

ActiveRecord::Schema.define(version: 20140927203126) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bills", force: true do |t|
    t.integer  "customer_id"
    t.integer  "supplier_id"
    t.date     "issue_date"
    t.date     "due_date"
    t.decimal  "amount",      precision: 8, scale: 2
    t.boolean  "paid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "payment_url"
    t.string   "paid_url"
    t.string   "view_url"
  end

  create_table "campaigns", force: true do |t|
    t.string   "name"
    t.string   "subject"
    t.string   "from_name"
    t.string   "from_email"
    t.datetime "sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "charges", force: true do |t|
    t.integer  "notification_id"
    t.integer  "service_id"
    t.decimal  "amount",          precision: 8, scale: 2
    t.string   "status"
    t.string   "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comment_id"
    t.date     "date"
  end

  create_table "comments", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "locale_id"
    t.string   "email"
    t.datetime "last_newsletter"
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "dues", force: true do |t|
    t.integer  "newsletter_id"
    t.integer  "bill_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "excepsions", force: true do |t|
    t.integer  "section_id"
    t.string   "section_type"
    t.string   "service"
    t.decimal  "amount",       precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "features", force: true do |t|
    t.integer  "plan_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "other"
    t.string   "recommended"
    t.string   "current"
  end

  create_table "lines", force: true do |t|
    t.integer  "section_id"
    t.string   "section_type"
    t.string   "part1"
    t.string   "part2"
    t.string   "part3"
    t.string   "part4"
    t.string   "part5"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "part6"
  end

  create_table "locales", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "newsletters", force: true do |t|
    t.integer  "customer_id"
    t.integer  "version_id"
    t.datetime "sent_at"
    t.string   "finding_1"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", force: true do |t|
    t.integer  "newsletter_id"
    t.integer  "bill_id"
    t.decimal  "prev_bill_amt", precision: 8, scale: 2
    t.string   "status"
    t.string   "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plans", force: true do |t|
    t.integer  "newsletter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "findings"
    t.integer  "othr_supplier_id"
    t.integer  "recc_supplier_id"
    t.integer  "curr_supplier_id"
    t.string   "othr_plan"
    t.string   "recc_plan"
    t.string   "curr_plan"
  end

  create_table "reminders", force: true do |t|
    t.integer  "newsletter_id"
    t.date     "date"
    t.string   "title"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suppliers", force: true do |t|
    t.string   "name"
    t.string   "logo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "payment_url"
    t.string   "description"
  end

  create_table "texts", force: true do |t|
    t.text     "header_external"
    t.text     "header_external_link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: true do |t|
    t.text     "header_external"
    t.text     "header_external_link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "locale_id"
    t.integer  "campaign_id"
    t.text     "header_title"
    t.datetime "approved_at"
    t.integer  "user_id"
    t.text     "findings_sentence"
    t.string   "dues_title"
    t.string   "notifications_title"
    t.string   "reminders_title"
    t.string   "plans_title"
    t.string   "dues_sentence"
    t.string   "notifications_sentence"
    t.string   "reminders_sentence"
    t.string   "plans_sentence"
  end

end
