class VPollutionPermitResults < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE VIEW v_pollution_permit_results AS 
      SELECT innr.project_id
            ,innr.chemical_name
            ,innr.chemical_element_name
            ,innr.chemical_element_cas
            ,innr.ta
            ,innr.ta / 1000000 / (innr.working_time * 3600) gs
            ,innr.ta / 1000000 / (innr.working_time * 3600) / innr.volume_rate * (innr.carbon_content / 100) * 1000 mgcm3
        FROM (SELECT prch.project_id
                    ,chem.name chemical_name
                    ,grel.name chemical_element_name
                    ,grel.cas chemical_element_cas
                    ,chel.max_percent / (SELECT SUM(chel2.max_percent)
                                           FROM chemical_elements chel2
                                          WHERE chel2.chemical_id = prch.chemical_id) * prch.amount * chem.loy / 100 ta
                    ,prch.working_time
                    ,(SELECT coso.volume_rate
                        FROM contamination_sources coso
                       WHERE coso.id = prch.contamination_source_id) AS volume_rate
                    ,(SELECT grou.carbon_content
                        FROM groups grou
                       WHERE grou.id = grel.group_id) AS carbon_content
                FROM project_chemicals prch
                JOIN chemicals chem ON chem.id = prch.chemical_id
                JOIN chemical_elements chel ON chem.id = chel.chemical_id
                JOIN group_elements grel ON grel.id = chel.group_element_id) AS innr
    SQL
  end

  def down
    execute <<-SQL
      DROP VIEW v_pollution_permit_results
    SQL
  end
end
