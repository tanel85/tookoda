class CreateChemicalElements < ActiveRecord::Migration
  def change
    create_table :chemical_elements do |t|
      t.belongs_to :chemical
      t.belongs_to :group_element
      t.float :max_percent
      # Add fields that let Rails automatically keep track
      # of when records are added or modified:
      t.timestamps
    end
    add_index :chemical_elements, :group_element_id
  end
end
