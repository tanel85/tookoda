class VPollutionPermitResults < ActiveRecord::Migration
  def up
    execute <<-SQL
CREATE OR REPLACE VIEW V_POLLUTION_PERMIT_RESULTS AS
SELECT prch.project_id
      ,prch.contamination_source_id
      ,grel.group_id
      ,(SELECT coso.code
          FROM contamination_sources coso
         WHERE coso.id = prch.contamination_source_id) AS contamination_source_code
      ,(SELECT grou.name
          FROM groups grou
         WHERE grou.id = grel.group_id) AS group_name
      ,SUM(innr.ta) AS ta
      ,SUM(innr.gs) AS gs
      ,SUM(innr.gs) / (SELECT coso.volume_rate
                         FROM contamination_sources coso
                        WHERE coso.id = prch.contamination_source_id) *
       ((SELECT grou.carbon_content
           FROM groups grou
          WHERE grou.id = grel.group_id) / 100) * 1000 mgcm3
  FROM (SELECT prch.id
              ,ta.ta
              ,ta.ta * 1000000 / (prch.working_time * 3600) gs
          FROM project_chemicals prch
          JOIN (SELECT prch2.id
                     ,chel.max_percent / (SELECT SUM(chel2.max_percent)
                                            FROM chemical_elements chel2
                                           WHERE chel2.chemical_id = prch2.chemical_id) * prch2.amount * chem.loy / 100 AS ta
                 FROM project_chemicals prch2
                 JOIN chemicals chem ON chem.id = prch2.chemical_id
                 JOIN chemical_elements chel ON chem.id = chel.chemical_id) ta ON (ta.id = prch.id)) innr
  JOIN project_chemicals prch ON (prch.id = innr.id)
  JOIN chemicals chem ON chem.id = prch.chemical_id
  JOIN chemical_elements chel ON chem.id = chel.chemical_id
  JOIN group_elements grel ON grel.id = chel.group_element_id
 GROUP BY prch.project_id
         ,prch.contamination_source_id
         ,grel.group_id
    SQL
  end

  def down
    execute <<-SQL
      DROP VIEW v_pollution_permit_results
    SQL
  end
end
