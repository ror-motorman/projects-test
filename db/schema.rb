# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_190_314_091_924) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'locations', force: :cascade do |t|
    t.integer 'project_id'
    t.string 'title'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'notification_templates', force: :cascade do |t|
    t.integer 'project_id'
    t.string 'title'
    t.text 'content'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.text 'suitable_roles', default: [], array: true
  end

  create_table 'projects', force: :cascade do |t|
    t.string 'title'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'roles', force: :cascade do |t|
    t.integer 'title'
    t.integer 'user_id'
    t.integer 'notification_template_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'name', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'invitation_token'
    t.datetime 'invitation_created_at'
    t.datetime 'invitation_sent_at'
    t.datetime 'invitation_accepted_at'
    t.integer 'invitation_limit'
    t.string 'invited_by_type'
    t.bigint 'invited_by_id'
    t.integer 'invitations_count', default: 0
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['invitation_token'], name: 'index_users_on_invitation_token', unique: true
    t.index ['invitations_count'], name: 'index_users_on_invitations_count'
    t.index ['invited_by_id'], name: 'index_users_on_invited_by_id'
    t.index %w[invited_by_type invited_by_id], name: 'index_users_on_invited_by_type_and_invited_by_id'
  end
end
