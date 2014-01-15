class VChemicalUsages < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE VIEW v_chemical_usages AS
      SELECT prch.id
            ,prch.project_id
            ,chem.name AS chemical_name
            ,chem.chemical_type
            ,chem.loy
            ,prch.amount
            ,chem.hazard_class
            ,chem.rh
            ,chem.sp
            ,snap.snap
            ,snap.name AS snap_name
            ,grou.cas AS group_cas
            ,grou.name AS group_name
            ,innr.ta
            ,innr.ta * 1000000 / (prch.working_time * 3600) gs
            ,(SELECT coso.name
                FROM contamination_sources coso
               WHERE coso.id = prch.contamination_source_id) AS cont_source_name
        FROM (SELECT prch2.id
                    ,grel.group_id
                    ,SUM(chel.max_percent / (SELECT SUM(chel2.max_percent)
                                               FROM chemical_elements chel2
                                              WHERE chel2.chemical_id = prch2.chemical_id) * prch2.amount * chem.loy / 100) AS ta
                FROM project_chemicals prch2
               INNER JOIN chemicals chem ON chem.id = prch2.chemical_id
               INNER JOIN chemical_elements chel ON chel.chemical_id = chem.id
               INNER JOIN group_elements grel ON (grel.id = chel.group_element_id)
               GROUP BY prch2.project_id
                       ,prch2.id
                       ,grel.group_id) innr
       INNER JOIN project_chemicals prch ON prch.id = innr.id
       INNER JOIN chemicals chem ON chem.id = prch.chemical_id
       INNER JOIN snaps snap ON snap.id = prch.snap_id
       INNER JOIN groups grou ON grou.id = innr.group_id
    SQL
  end

  def down
    execute <<-SQL
      DROP VIEW v_chemical_usages
    SQL
  end
end
