class VPollutionAmounts < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE VIEW v_pollution_amounts AS
      SELECT prch.project_id
            ,snap.snap
            ,snap.name AS snap_name
            ,coso.name AS cont_source_name
            ,coso.code AS cont_source_code
            ,coso.x_coordinate
            ,coso.y_coordinate
            ,coso.diameter
            ,coso.height
            ,coso.volume_rate/((coso.diameter/2)*(coso.diameter/2)*3.14) AS line_speed
            ,coso.temperature
            ,ppre.chemical_element_cas
            ,ppre.chemical_element_name
            ,ppre.gs
            ,ppre.ta
        FROM project_chemicals prch
       INNER JOIN v_pollution_permit_results ppre ON (ppre.project_id = prch.project_id)
       INNER JOIN snaps snap ON (snap.id = prch.snap_id)
       INNER JOIN contamination_sources coso ON (coso.id = prch.contamination_source_id)
    SQL
  end

  def down
    execute <<-SQL
      DROP VIEW v_pollution_amounts
    SQL
  end
end
