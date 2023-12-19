# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_12_19_112503) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "baselines", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "browser"
    t.string "size"
    t.integer "suite_id"
    t.string "screenshot_uid"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "key"
    t.integer "test_id"
    t.index ["suite_id"], name: "index_baselines_on_suite_id"
  end

  create_table "projects", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "slug"
  end

  create_table "runs", id: :serial, force: :cascade do |t|
    t.integer "suite_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "sequential_id"
    t.string "commit"
    t.index ["suite_id"], name: "index_runs_on_suite_id"
  end

  create_table "suites", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "project_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "slug"
    t.index ["project_id"], name: "index_suites_on_project_id"
  end

  create_table "tests", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "browser"
    t.string "size"
    t.integer "run_id"
    t.float "diff"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "screenshot_uid"
    t.string "screenshot_baseline_uid"
    t.string "screenshot_diff_uid"
    t.string "key"
    t.boolean "pass"
    t.string "source_url"
    t.string "fuzz_level"
    t.string "highlight_colour"
    t.string "crop_area"
    t.index ["run_id"], name: "index_tests_on_run_id"
  end

  add_foreign_key "baselines", "suites"
  add_foreign_key "runs", "suites"
  add_foreign_key "tests", "runs"
end
