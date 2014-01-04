class CreateProjects < ActiveRecord::Migration
  def up
    create_table :projects do |t|
      t.string :name
      # Add fields that let Rails automatically keep track
      # of when records are added or modified:
      t.timestamps
    end
  end

  def down
    drop_table :projects
  end
end