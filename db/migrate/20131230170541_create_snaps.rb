class CreateSnaps < ActiveRecord::Migration
  def change
    create_table :snaps do |t|
      t.string :snap
      t.string :name     
      # Add fields that let Rails automatically keep track
      # of when records are added or modified:
      t.timestamps
    end
  end
end
