class CreateGroupElements < ActiveRecord::Migration
  def change
    create_table :group_elements do |t|
      t.belongs_to :group
      t.string :cas
      t.string :name
      # Add fields that let Rails automatically keep track
      # of when records are added or modified:
      t.timestamps
    end
    add_index :group_elements, :group_id
  end
end
