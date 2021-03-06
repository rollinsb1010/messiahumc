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

ActiveRecord::Schema.define(:version => 20121111172515) do

  create_table "combined_search_items", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "url"
    t.text     "index_data"
    t.integer  "source_id"
    t.string   "source_type"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "refinery_copywriting_phrase_translations", :force => true do |t|
    t.integer  "refinery_copywriting_phrase_id"
    t.string   "locale"
    t.text     "value"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "refinery_copywriting_phrase_translations", ["locale"], :name => "index_copywriting_phrase_translations_on_locale"
  add_index "refinery_copywriting_phrase_translations", ["refinery_copywriting_phrase_id"], :name => "index_c8fbec01a288d0aef8ba987126084c4d06953304"

  create_table "refinery_copywriting_phrases", :force => true do |t|
    t.string   "name"
    t.text     "default"
    t.text     "value"
    t.string   "scope"
    t.integer  "page_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "phrase_type"
    t.date     "last_access_at"
  end

  add_index "refinery_copywriting_phrases", ["name", "scope"], :name => "index_copywriting_phrases_on_name_and_scope"

  create_table "refinery_event_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "slug"
  end

  add_index "refinery_event_categories", ["slug"], :name => "index_refinery_event_categories_on_slug", :unique => true

  create_table "refinery_event_categorizations", :force => true do |t|
    t.integer  "event_id"
    t.integer  "event_category_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "refinery_events", :force => true do |t|
    t.string   "title"
    t.date     "date"
    t.string   "start_time"
    t.string   "end_time"
    t.string   "repeats"
    t.string   "location"
    t.string   "short_description"
    t.text     "long_description"
    t.string   "contact_name"
    t.string   "contact_email"
    t.string   "contact_phone"
    t.string   "notes"
    t.integer  "image_id"
    t.integer  "ministry_id"
    t.boolean  "highlighted"
    t.integer  "position"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "slug"
  end

  add_index "refinery_events", ["slug"], :name => "index_refinery_events_on_slug", :unique => true

  create_table "refinery_image_page_translations", :force => true do |t|
    t.integer  "refinery_image_page_id"
    t.string   "locale"
    t.text     "caption"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  add_index "refinery_image_page_translations", ["locale"], :name => "index_refinery_image_page_translations_on_locale"
  add_index "refinery_image_page_translations", ["refinery_image_page_id"], :name => "index_186c9a170a0ab319c675aa80880ce155d8f47244"

  create_table "refinery_image_pages", :force => true do |t|
    t.integer "image_id"
    t.integer "page_id"
    t.integer "position"
    t.text    "caption"
    t.string  "page_type", :default => "page"
  end

  add_index "refinery_image_pages", ["image_id"], :name => "index_refinery_image_pages_on_image_id"
  add_index "refinery_image_pages", ["page_id"], :name => "index_refinery_image_pages_on_page_id"

  create_table "refinery_images", :force => true do |t|
    t.string   "image_mime_type"
    t.string   "image_name"
    t.integer  "image_size"
    t.integer  "image_width"
    t.integer  "image_height"
    t.string   "image_uid"
    t.string   "image_ext"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "refinery_messengers", :force => true do |t|
    t.string   "messenger_type"
    t.date     "published_at"
    t.integer  "pdf_file_id"
    t.integer  "position"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "refinery_ministries", :force => true do |t|
    t.string   "name"
    t.integer  "ministry_category_id"
    t.text     "description"
    t.integer  "logo_id"
    t.integer  "position"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "slug"
    t.boolean  "highlighted"
  end

  add_index "refinery_ministries", ["slug"], :name => "index_refinery_ministries_on_slug"

  create_table "refinery_ministry_categories", :force => true do |t|
    t.string   "name"
    t.string   "index_placement"
    t.integer  "position"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "slug"
  end

  add_index "refinery_ministry_categories", ["slug"], :name => "index_refinery_ministry_categories_on_slug"

  create_table "refinery_mission_categories", :force => true do |t|
    t.string   "name"
    t.string   "index_placement"
    t.integer  "position"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "slug"
  end

  add_index "refinery_mission_categories", ["slug"], :name => "index_refinery_mission_categories_on_slug"

  create_table "refinery_missions", :force => true do |t|
    t.string   "name"
    t.integer  "mission_category_id"
    t.text     "description"
    t.integer  "logo_id"
    t.boolean  "highlighted"
    t.integer  "position"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "slug"
  end

  add_index "refinery_missions", ["slug"], :name => "index_refinery_missions_on_slug"

  create_table "refinery_page_part_translations", :force => true do |t|
    t.integer  "refinery_page_part_id"
    t.string   "locale"
    t.text     "body"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "refinery_page_part_translations", ["locale"], :name => "index_refinery_page_part_translations_on_locale"
  add_index "refinery_page_part_translations", ["refinery_page_part_id"], :name => "index_f9716c4215584edbca2557e32706a5ae084a15ef"

  create_table "refinery_page_parts", :force => true do |t|
    t.integer  "refinery_page_id"
    t.string   "title"
    t.text     "body"
    t.integer  "position"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "refinery_page_parts", ["id"], :name => "index_refinery_page_parts_on_id"
  add_index "refinery_page_parts", ["refinery_page_id"], :name => "index_refinery_page_parts_on_refinery_page_id"

  create_table "refinery_page_translations", :force => true do |t|
    t.integer  "refinery_page_id"
    t.string   "locale"
    t.string   "title"
    t.string   "custom_slug"
    t.string   "menu_title"
    t.string   "slug"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "refinery_page_translations", ["locale"], :name => "index_refinery_page_translations_on_locale"
  add_index "refinery_page_translations", ["refinery_page_id"], :name => "index_d079468f88bff1c6ea81573a0d019ba8bf5c2902"

  create_table "refinery_pages", :force => true do |t|
    t.integer  "parent_id"
    t.string   "path"
    t.string   "slug"
    t.boolean  "show_in_menu",        :default => true
    t.string   "link_url"
    t.string   "menu_match"
    t.boolean  "deletable",           :default => true
    t.boolean  "draft",               :default => false
    t.boolean  "skip_to_first_child", :default => false
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.string   "view_template"
    t.string   "layout_template"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "refinery_pages", ["depth"], :name => "index_refinery_pages_on_depth"
  add_index "refinery_pages", ["id"], :name => "index_refinery_pages_on_id"
  add_index "refinery_pages", ["lft"], :name => "index_refinery_pages_on_lft"
  add_index "refinery_pages", ["parent_id"], :name => "index_refinery_pages_on_parent_id"
  add_index "refinery_pages", ["rgt"], :name => "index_refinery_pages_on_rgt"

  create_table "refinery_participants", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.integer  "signup_slot_id"
    t.integer  "signup_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "refinery_pastors", :force => true do |t|
    t.string   "name"
    t.string   "job_title"
    t.integer  "photo_id"
    t.text     "bio"
    t.string   "email"
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "slug"
  end

  add_index "refinery_pastors", ["slug"], :name => "index_refinery_pastors_on_slug"

  create_table "refinery_resources", :force => true do |t|
    t.string   "file_mime_type"
    t.string   "file_name"
    t.integer  "file_size"
    t.string   "file_uid"
    t.string   "file_ext"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "refinery_roles", :force => true do |t|
    t.string "title"
  end

  create_table "refinery_roles_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "refinery_roles_users", ["role_id", "user_id"], :name => "index_refinery_roles_users_on_role_id_and_user_id"
  add_index "refinery_roles_users", ["user_id", "role_id"], :name => "index_refinery_roles_users_on_user_id_and_role_id"

  create_table "refinery_sermon_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "slug"
  end

  add_index "refinery_sermon_categories", ["slug"], :name => "index_refinery_sermon_categories_on_slug"

  create_table "refinery_sermons", :force => true do |t|
    t.integer  "pastor_id"
    t.date     "date"
    t.string   "title"
    t.string   "location"
    t.text     "description"
    t.string   "scripture_reading"
    t.integer  "mp3_file_id"
    t.integer  "image_id"
    t.integer  "position"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "slug"
  end

  add_index "refinery_sermons", ["slug"], :name => "index_refinery_sermons_on_slug"

  create_table "refinery_sermons_sermon_categories", :force => true do |t|
    t.integer "sermon_id"
    t.integer "category_id"
  end

  add_index "refinery_sermons_sermon_categories", ["category_id"], :name => "index_refinery_sermons_sermon_categories_on_category_id"
  add_index "refinery_sermons_sermon_categories", ["sermon_id"], :name => "index_refinery_sermons_sermon_categories_on_sermon_id"

  create_table "refinery_signup_slots", :force => true do |t|
    t.string   "description"
    t.integer  "available_slots"
    t.integer  "signup_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "refinery_signups", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "description"
    t.string   "responsible_name"
    t.string   "responsible_email"
    t.string   "responsible_phone"
    t.string   "dates"
    t.string   "times"
    t.integer  "position"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "refinery_staff_categories", :force => true do |t|
    t.string   "name"
    t.string   "index_placement"
    t.integer  "position"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "slug"
  end

  add_index "refinery_staff_categories", ["slug"], :name => "index_refinery_staff_categories_on_slug"

  create_table "refinery_staff_members", :force => true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.string   "job_title"
    t.integer  "photo_id"
    t.text     "bio"
    t.string   "email"
    t.integer  "position"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "slug"
  end

  add_index "refinery_staff_members", ["slug"], :name => "index_refinery_staff_members_on_slug"

  create_table "refinery_user_plugins", :force => true do |t|
    t.integer "user_id"
    t.string  "name"
    t.integer "position"
  end

  add_index "refinery_user_plugins", ["name"], :name => "index_refinery_user_plugins_on_name"
  add_index "refinery_user_plugins", ["user_id", "name"], :name => "index_refinery_user_plugins_on_user_id_and_name", :unique => true

  create_table "refinery_users", :force => true do |t|
    t.string   "username",               :null => false
    t.string   "email",                  :null => false
    t.string   "encrypted_password",     :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "sign_in_count"
    t.datetime "remember_created_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  add_index "refinery_users", ["id"], :name => "index_refinery_users_on_id"

  create_table "seo_meta", :force => true do |t|
    t.integer  "seo_meta_id"
    t.string   "seo_meta_type"
    t.string   "browser_title"
    t.string   "meta_keywords"
    t.text     "meta_description"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "seo_meta", ["id"], :name => "index_seo_meta_on_id"
  add_index "seo_meta", ["seo_meta_id", "seo_meta_type"], :name => "index_seo_meta_on_seo_meta_id_and_seo_meta_type"

end
