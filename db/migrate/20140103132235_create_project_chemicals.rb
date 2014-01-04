class CreateProjectChemicals < ActiveRecord::Migration
  def change
    create_table :project_chemicals do |t|
      t.belongs_to :project
      t.belongs_to :chemical
      t.belongs_to :snap
      t.belongs_to :contamination_source
      t.float :amount
      t.float :working_time
      # Add fields that let Rails automatically keep track
      # of when records are added or modified:
      t.timestamps
    end
    add_index :project_chemicals, :project_id
    add_index :project_chemicals, :chemical_id
    add_index :project_chemicals, :snap_id
    add_index :project_chemicals, :contamination_source_id
  end
end
