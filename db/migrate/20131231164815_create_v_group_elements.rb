class CreateVGroupElements < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE VIEW v_group_elements AS SELECT e.id, e.cas, e.name, (SELECT g.name FROM GROUPS g WHERE g.id = e.group_id) group_name FROM group_elements e
    SQL
  end

  def down
    execute <<-SQL
      DROP VIEW v_group_elements
    SQL
  end
end
