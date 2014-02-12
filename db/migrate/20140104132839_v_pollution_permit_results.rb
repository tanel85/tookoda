class VPollutionPermitResults < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE VIEW v_pollution_permit_results AS 
       SELECT prch.project_id
             ,prch.contamination_source_id
             ,innr.group_id
             ,(SELECT coso.code
                 FROM contamination_sources coso
                WHERE coso.id = prch.contamination_source_id) AS contamination_source_code
             ,(SELECT grou.name
                 FROM groups grou
                WHERE grou.id = innr.group_id) AS group_name
             ,SUM(innr.ta) AS ta
             ,SUM(innr.gs) AS gs
             ,SUM(innr.gs) / ((SELECT coso.volume_rate
                                FROM contamination_sources coso
                               WHERE coso.id = prch.contamination_source_id)) *
              (((SELECT grou.carbon_content
                   FROM groups grou
                  WHERE grou.id = innr.group_id)) / 100) * 1000 AS mgcm3
         FROM (SELECT prch_1.id
                     ,ta.group_id
                     ,ta.ta
                     ,ta.ta * 1000000 / (prch_1.working_time * 3600) AS gs
                 FROM project_chemicals prch_1
                 JOIN (SELECT prch2.id
                            ,(SELECT grel.group_id
                                FROM group_elements grel
                               WHERE grel.id = chel_1.group_element_id) AS group_id
                            ,chel_1.max_percent / ((SELECT SUM(chel2.max_percent) AS SUM
                                                      FROM chemical_elements chel2
                                                     WHERE chel2.chemical_id = prch2.chemical_id)) * prch2.amount *
                             chem_1.loy / 100 AS ta
                        FROM project_chemicals prch2
                        JOIN chemicals chem_1 ON chem_1.id = prch2.chemical_id
                        JOIN chemical_elements chel_1 ON chem_1.id = chel_1.chemical_id) ta ON ta.id = prch_1.id) innr
         JOIN project_chemicals prch ON prch.id = innr.id
         JOIN chemicals chem ON chem.id = prch.chemical_id
        GROUP BY prch.project_id
                ,prch.contamination_source_id
                ,innr.group_id;
    SQL
  end

  def down
    execute <<-SQL
      DROP VIEW v_pollution_permit_results
    SQL
  end
end
