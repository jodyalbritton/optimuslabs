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

ActiveRecord::Schema.define(version: 20140611033602) do

  create_table "admin_rate_types", force: true do |t|
    t.string   "name"
    t.integer  "unit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "categories", ["slug"], name: "index_categories_on_slug", unique: true, using: :btree

  create_table "clients", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "configurables", force: true do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "configurables", ["name"], name: "index_configurables_on_name", using: :btree

  create_table "contacts", force: true do |t|
    t.string   "full_name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.integer  "client_id"
    t.text     "notes"
    t.string   "customer_number"
    t.datetime "customer_since"
    t.string   "first_interaction"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "contacts", ["client_id"], name: "index_contacts_on_client_id", using: :btree
  add_index "contacts", ["user_id"], name: "index_contacts_on_user_id", using: :btree

  create_table "conversations", force: true do |t|
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "interactions", force: true do |t|
    t.integer  "interactive_id"
    t.string   "interactive_type"
    t.string   "event"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "content"
  end

  create_table "invoices", force: true do |t|
    t.string   "subject"
    t.integer  "client_id"
    t.date     "started_on"
    t.date     "completed_on"
    t.decimal  "total",        precision: 10, scale: 0
    t.text     "notes"
    t.string   "attention"
    t.integer  "inv_number"
    t.decimal  "balance",      precision: 10, scale: 0
    t.boolean  "paid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invoices", ["client_id"], name: "index_invoices_on_client_id", using: :btree

  create_table "items", force: true do |t|
    t.decimal  "cost",             precision: 10, scale: 0
    t.string   "name"
    t.text     "description"
    t.integer  "item_num"
    t.integer  "quantity"
    t.integer  "invoice_id"
    t.integer  "purchasable_id"
    t.string   "purchasable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "message_receipts", force: true do |t|
    t.integer  "receivable_id"
    t.string   "receivable_type"
    t.integer  "message_id"
    t.boolean  "read"
    t.boolean  "trashed"
    t.boolean  "deleted"
    t.string   "mailbox_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sender_id"
    t.string   "sender_type"
  end

  add_index "message_receipts", ["message_id"], name: "index_message_receipts_on_message_id", using: :btree

  create_table "message_reciepts", force: true do |t|
    t.integer  "receivable_id"
    t.string   "receivable_type"
    t.integer  "message_id"
    t.boolean  "read"
    t.boolean  "trashed"
    t.boolean  "deleted"
    t.string   "mailbox_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "message_reciepts", ["message_id"], name: "index_message_reciepts_on_message_id", using: :btree

  create_table "messages", force: true do |t|
    t.string   "type"
    t.integer  "sender_id"
    t.integer  "conversation_id"
    t.integer  "client_id"
    t.integer  "project_id"
    t.string   "sender_type"
    t.string   "notification_code"
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "source"
    t.text     "body"
    t.string   "subject"
    t.boolean  "draft"
    t.string   "attachment"
    t.datetime "expires"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.integer  "contact_id"
  end

  add_index "messages", ["client_id"], name: "index_messages_on_client_id", using: :btree
  add_index "messages", ["contact_id"], name: "index_messages_on_contact_id", using: :btree
  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree
  add_index "messages", ["project_id"], name: "index_messages_on_project_id", using: :btree
  add_index "messages", ["sender_id"], name: "index_messages_on_sender_id", using: :btree

  create_table "notes", force: true do |t|
    t.string   "subject"
    t.string   "body"
    t.integer  "created_by_id"
    t.integer  "notable_id"
    t.string   "notable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notes", ["created_by_id"], name: "index_notes_on_created_by_id", using: :btree

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.date     "published_at"
    t.integer  "author_id"
    t.boolean  "draft"
    t.text     "excerpt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.string   "slug"
    t.integer  "site_id"
  end

  add_index "posts", ["author_id"], name: "index_posts_on_author_id", using: :btree
  add_index "posts", ["category_id"], name: "index_posts_on_category_id", using: :btree
  add_index "posts", ["site_id"], name: "index_posts_on_site_id", using: :btree
  add_index "posts", ["slug"], name: "index_posts_on_slug", unique: true, using: :btree

  create_table "rate_types", force: true do |t|
    t.string   "name"
    t.integer  "unit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name",        null: false
    t.string   "title",       null: false
    t.text     "description", null: false
    t.text     "the_role",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", force: true do |t|
    t.string   "name"
    t.string   "summary"
    t.text     "description"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo_icon"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "header_file_name"
    t.string   "header_content_type"
    t.integer  "header_file_size"
    t.datetime "header_updated_at"
    t.decimal  "price",               precision: 30, scale: 10
    t.decimal  "cost",                precision: 30, scale: 10
    t.decimal  "duration",            precision: 30, scale: 10
    t.integer  "rate_type_id"
  end

  add_index "services", ["category_id"], name: "index_services_on_category_id", using: :btree
  add_index "services", ["rate_type_id"], name: "index_services_on_rate_type_id", using: :btree

  create_table "settings", force: true do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree

  create_table "sites", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subdomain"
  end

  create_table "sponsors", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "category_id"
    t.boolean  "enabled"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "url"
    t.string   "video_url"
    t.string   "phone"
    t.string   "email"
    t.integer  "client_id"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "slug"
  end

  add_index "sponsors", ["category_id"], name: "index_sponsors_on_category_id", using: :btree
  add_index "sponsors", ["client_id"], name: "index_sponsors_on_client_id", using: :btree
  add_index "sponsors", ["slug"], name: "index_sponsors_on_slug", unique: true, using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "tasks", force: true do |t|
    t.string   "item"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "importance"
    t.datetime "completed_at"
    t.boolean  "completed",    default: false
    t.integer  "client_id"
    t.integer  "user_id"
  end

  add_index "tasks", ["client_id"], name: "index_tasks_on_client_id", using: :btree
  add_index "tasks", ["user_id"], name: "index_tasks_on_user_id", using: :btree

  create_table "tickets", force: true do |t|
    t.string   "subject"
    t.integer  "client_id"
    t.text     "description"
    t.string   "severity"
    t.string   "status"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tickets", ["client_id"], name: "index_tickets_on_client_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "first_name",             default: "", null: false
    t.string   "last_name",              default: "", null: false
    t.string   "telephone",              default: "", null: false
    t.string   "address",                default: "", null: false
    t.string   "city",                   default: "", null: false
    t.string   "state",                  default: "", null: false
    t.string   "zip",                    default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
