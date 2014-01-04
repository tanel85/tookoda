class CreateChemicals < ActiveRecord::Migration
  def change
    create_table :chemicals do |t|
      t.string :name
      t.string :chemical_type
      t.float :loy
      t.string :hazard_class
      t.string :rh
      t.string :sp
      # Add fields that let Rails automatically keep track
      # of when records are added or modified:
      t.timestamps
    end
  end
end
