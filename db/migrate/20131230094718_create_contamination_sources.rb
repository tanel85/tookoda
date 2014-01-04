class CreateContaminationSources < ActiveRecord::Migration
  def change
    create_table :contamination_sources do |t|
      t.belongs_to :project
      t.string :name
      t.string :code
      t.float :diameter
      t.float :height
      t.integer :temperature
      t.float :x_coordinate
      t.float :y_coordinate
      t.float :volume_rate #mahtkiirus
      
      # Add fields that let Rails automatically keep track
      # of when records are added or modified:
      t.timestamps
    end
    add_index :contamination_sources, :project_id
  end
end
