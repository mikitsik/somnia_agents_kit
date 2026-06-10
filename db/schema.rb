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

ActiveRecord::Schema[8.1].define(version: 2026_06_10_130206) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "agent_requests", force: :cascade do |t|
    t.string "agent_id", null: false
    t.string "agent_kind", null: false
    t.string "callback_tx_hash"
    t.datetime "created_at", null: false
    t.text "error_message"
    t.jsonb "payload", default: {}, null: false
    t.string "request_id"
    t.string "request_tx_hash"
    t.jsonb "response", default: {}, null: false
    t.string "status", default: "draft", null: false
    t.datetime "updated_at", null: false
    t.index ["agent_id"], name: "index_agent_requests_on_agent_id"
    t.index ["agent_kind"], name: "index_agent_requests_on_agent_kind"
    t.index ["request_id"], name: "index_agent_requests_on_request_id", unique: true
    t.index ["request_tx_hash"], name: "index_agent_requests_on_request_tx_hash"
    t.index ["status"], name: "index_agent_requests_on_status"
  end
end
