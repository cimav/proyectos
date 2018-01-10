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

ActiveRecord::Schema.define(version: 20180110231600) do

  create_table "audits", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_id", "associated_type"], name: "associated_index"
    t.index ["auditable_id", "auditable_type"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "business_units", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "short_name"
    t.string "real_name"
    t.text "address"
    t.bigint "company_size_id"
    t.bigint "industry_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_size_id"], name: "index_clients_on_company_size_id"
    t.index ["industry_id"], name: "index_clients_on_industry_id"
  end

  create_table "company_sizes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "departments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_departments_on_user_id"
  end

  create_table "industries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "institutions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "short_name"
    t.string "name"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title"
    t.text "content"
    t.bigint "project_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status"
    t.integer "message_type"
    t.index ["project_id"], name: "index_messages_on_project_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "people", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "people_type"
    t.string "name"
    t.string "email"
    t.string "phone"
    t.text "notes"
    t.string "image"
    t.integer "attachable_id"
    t.string "attachable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "project_files", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.bigint "project_folder_id"
    t.text "description"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "file"
    t.index ["project_folder_id"], name: "index_project_files_on_project_folder_id"
    t.index ["user_id"], name: "index_project_files_on_user_id"
  end

  create_table "project_folders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.text "description"
    t.integer "parent_folder"
    t.integer "folder_type"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "project_id"
    t.index ["user_id"], name: "index_project_folders_on_user_id"
  end

  create_table "project_institutions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "project_id"
    t.bigint "institution_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["institution_id"], name: "index_project_institutions_on_institution_id"
    t.index ["project_id"], name: "index_project_institutions_on_project_id"
  end

  create_table "project_participants", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "project_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_participants_on_project_id"
    t.index ["user_id"], name: "index_project_participants_on_user_id"
  end

  create_table "project_people", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "project_id"
    t.bigint "people_id"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["people_id"], name: "index_project_people_on_people_id"
    t.index ["project_id"], name: "index_project_people_on_project_id"
  end

  create_table "project_statuses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.integer "position"
    t.bigint "project_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_type_id"], name: "index_project_statuses_on_project_type_id"
  end

  create_table "project_themes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "project_id"
    t.bigint "theme_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_themes_on_project_id"
    t.index ["theme_id"], name: "index_project_themes_on_theme_id"
  end

  create_table "project_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
  end

  create_table "projects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.bigint "client_id"
    t.string "number"
    t.string "internal_name"
    t.text "goal"
    t.integer "manager_id"
    t.integer "agent_id"
    t.integer "department_id"
    t.integer "business_unit_id"
    t.integer "project_type_id"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "results"
    t.string "erp_number"
    t.integer "research_type"
    t.index ["client_id"], name: "index_projects_on_client_id"
  end

  create_table "required_files", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "project_type_id"
    t.bigint "required_folder_id"
    t.string "name"
    t.text "description"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_type_id"], name: "index_required_files_on_project_type_id"
    t.index ["required_folder_id"], name: "index_required_files_on_required_folder_id"
    t.index ["user_id"], name: "index_required_files_on_user_id"
  end

  create_table "required_folders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "project_type_id"
    t.integer "parent_folder"
    t.string "name"
    t.text "description"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_type_id"], name: "index_required_folders_on_project_type_id"
    t.index ["user_id"], name: "index_required_folders_on_user_id"
  end

  create_table "schedule_participants", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "schedule_id"
    t.integer "participant_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["schedule_id"], name: "index_schedule_participants_on_schedule_id"
    t.index ["user_id"], name: "index_schedule_participants_on_user_id"
  end

  create_table "schedules", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title"
    t.text "content"
    t.bigint "project_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "schedule_type"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status"
    t.boolean "all_day"
    t.index ["project_id"], name: "index_schedules_on_project_id"
    t.index ["user_id"], name: "index_schedules_on_user_id"
  end

  create_table "themes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "first_name"
    t.string "email"
    t.bigint "department_id"
    t.string "status"
    t.integer "supervisor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "access"
    t.string "last_name"
    t.integer "business_unit_id"
    t.index ["department_id"], name: "index_users_on_department_id"
  end

  add_foreign_key "departments", "users"
  add_foreign_key "messages", "projects"
  add_foreign_key "messages", "users"
  add_foreign_key "project_files", "project_folders"
  add_foreign_key "project_files", "users"
  add_foreign_key "project_folders", "users"
  add_foreign_key "project_institutions", "institutions"
  add_foreign_key "project_institutions", "projects"
  add_foreign_key "project_participants", "projects"
  add_foreign_key "project_participants", "users"
  add_foreign_key "project_people", "people", column: "people_id"
  add_foreign_key "project_people", "projects"
  add_foreign_key "project_statuses", "project_types"
  add_foreign_key "project_themes", "projects"
  add_foreign_key "project_themes", "themes"
  add_foreign_key "required_files", "project_types"
  add_foreign_key "required_files", "required_folders"
  add_foreign_key "required_files", "users"
  add_foreign_key "required_folders", "project_types"
  add_foreign_key "required_folders", "users"
  add_foreign_key "schedule_participants", "schedules"
  add_foreign_key "schedule_participants", "users"
  add_foreign_key "schedules", "projects"
  add_foreign_key "schedules", "users"
end
