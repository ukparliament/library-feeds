class CreateSchema < ActiveRecord::Migration[7.2]
  def change
    create_schema "heroku_ext"

    # These are extensions that must be enabled in order to support this database
    enable_extension "pg_stat_statements"
    enable_extension "plpgsql"

    create_table "articles", id: :serial, force: :cascade do |t|
      t.string "title", limit: 500, null: false
      t.string "author", limit: 255
      t.string "link", limit: 255, null: false
      t.datetime "published_at", precision: nil, null: false
      t.string "guid", limit: 255, null: false
      t.boolean "is_posted_to_bluesky", default: false
      t.boolean "is_posted_to_mastodon", default: false
      t.integer "publisher_id", null: false
      t.datetime "created_at", precision: nil
    end

    create_table "publishers", id: :serial, force: :cascade do |t|
      t.string "name", limit: 500, null: false
    end

    add_foreign_key "articles", "publishers", name: "fk_article"
  end
end
