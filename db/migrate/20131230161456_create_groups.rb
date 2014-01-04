class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :cas
      t.string :name
      t.float :carbon_content      
      # Add fields that let Rails automatically keep track
      # of when records are added or modified:
      t.timestamps
    end
  end
end
