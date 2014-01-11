class VPollutionAmounts < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE VIEW v_pollution_amounts AS
      SELECT ppre.project_id
            ,(SELECT snap.snap
                FROM snaps snap
               WHERE snap.id = (SELECT MAX(prch.snap_id)
                                  FROM project_chemicals prch
                                 WHERE prch.project_id = ppre.project_id
                                   AND prch.contamination_source_id = ppre.contamination_source_id)) AS snap
            ,(SELECT snap.name
                FROM snaps snap
               WHERE snap.id = (SELECT MAX(prch.snap_id)
                                  FROM project_chemicals prch
                                 WHERE prch.project_id = ppre.project_id
                                   AND prch.contamination_source_id = ppre.contamination_source_id)) AS snap_name
            ,coso.name AS cont_source_name
            ,coso.code AS cont_source_code
            ,coso.x_coordinate
            ,coso.y_coordinate
            ,coso.diameter
            ,coso.height
            ,coso.volume_rate / ((coso.diameter / 2) * (coso.diameter / 2) * 3.14) AS line_speed
            ,coso.temperature
            ,grou.name AS group_name
            ,grou.cas AS group_cas
            ,ppre.gs
            ,ppre.ta
        FROM v_pollution_permit_results ppre
        JOIN contamination_sources coso ON (coso.id = ppre.contamination_source_id)
        JOIN groups grou ON grou.id = ppre.group_id
    SQL
  end

  def down
    execute <<-SQL
      DROP VIEW v_pollution_amounts
    SQL
  end
end
