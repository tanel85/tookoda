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

ActiveRecord::Schema.define(:version => 20140115200322) do

  create_table "chemical_elements", :force => true do |t|
    t.integer  "chemical_id",      :precision => 38, :scale => 0
    t.integer  "group_element_id", :precision => 38, :scale => 0
    t.decimal  "max_percent"
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
  end

  add_index "chemical_elements", ["group_element_id"], :name => "i_che_ele_gro_ele_id"

  create_table "chemicals", :force => true do |t|
    t.string   "name"
    t.string   "chemical_type"
    t.decimal  "loy"
    t.string   "hazard_class"
    t.string   "rh"
    t.string   "sp"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "contamination_sources", :force => true do |t|
    t.integer  "project_id",   :precision => 38, :scale => 0
    t.string   "name"
    t.string   "code"
    t.decimal  "diameter"
    t.decimal  "height"
    t.integer  "temperature",  :precision => 38, :scale => 0
    t.decimal  "x_coordinate"
    t.decimal  "y_coordinate"
    t.decimal  "volume_rate"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  add_index "contamination_sources", ["project_id"], :name => "i_con_sou_wor_id"

  create_table "group_elements", :force => true do |t|
    t.integer  "group_id",   :precision => 38, :scale => 0
    t.string   "cas"
    t.string   "name"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "group_elements", ["group_id"], :name => "i_group_elements_group_id"

  create_table "groups", :force => true do |t|
    t.string   "cas"
    t.string   "name"
    t.decimal  "carbon_content"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "project_chemicals", :force => true do |t|
    t.integer  "project_id",              :precision => 38, :scale => 0
    t.integer  "chemical_id",             :precision => 38, :scale => 0
    t.integer  "snap_id",                 :precision => 38, :scale => 0
    t.integer  "contamination_source_id", :precision => 38, :scale => 0
    t.decimal  "amount"
    t.decimal  "working_time"
    t.datetime "created_at",                                             :null => false
    t.datetime "updated_at",                                             :null => false
  end

  add_index "project_chemicals", ["chemical_id"], :name => "i_pro_che_che_id"
  add_index "project_chemicals", ["contamination_source_id"], :name => "i_pro_che_con_sou_id"
  add_index "project_chemicals", ["project_id"], :name => "i_pro_che_wor_id"
  add_index "project_chemicals", ["snap_id"], :name => "i_project_chemicals_snap_id"

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "snaps", :force => true do |t|
    t.string   "snap"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
