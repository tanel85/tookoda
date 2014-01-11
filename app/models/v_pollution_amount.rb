# encoding: UTF-8
class VPollutionAmount < ActiveRecord::Base

  attr_accessible :project_id, :snap, :snap_name, :cont_source_name, :cont_source_code, :x_coordinate, :y_coordinate,
    :diameter, :height, :line_speed, :temperature, :chemical_element_cas, :chemical_element_name, :gs, :ta
    
  def self.generate_report project_id
    p = Axlsx::Package.new
    p.workbook.add_worksheet(:name => "Saasteainete heitkogused") do |sheet|
      add_header sheet
      add_rows sheet, project_id
    end
    ReportHelper.xlsx_to_string p
  end
  
  def self.add_header sheet
    sheet.add_row ["Tegevusala, tehnoloogiaprotsess või seade", "", "Saasteallika ja väljuvate gaaside parameetrid",
       "", "", "", "", "", "", "", "Välisõhku eralduv saasteaine", "", "", ""]
    sheet.merge_cells "A1:B1"
    sheet.merge_cells "C1:J1"
    sheet.merge_cells "K1:N1"
    sheet.add_row ["SNAPi kood", "Nimetus", "Nimetus", "Nr plaanil või kaardil", "L-EST97 koordinaadid (pindallika korral koordinaadipaar - alumine vasak ja ülemine parem nurk)", 
      "", "Ava läbimõõt, m", "Väljumiskõrgus maapinnast, m", "Joonkiirus, m/s", "Temperatuur, °C", "CAS nr", "Nimetus", "Heitkogus", ""]
    sheet.merge_cells "E2:F2"
    sheet.merge_cells "M2:N2"
    sheet.add_row ["", "", "", "", "X", "Y", "", "", "", "", "", "", "hetkeline, g/s", "tonnides aastas"]
    sheet.merge_cells "A2:A3"
    sheet.merge_cells "B2:B3"
    sheet.merge_cells "C2:C3"
    sheet.merge_cells "D2:D3"
    sheet.merge_cells "G2:G3"
    sheet.merge_cells "H2:H3"
    sheet.merge_cells "I2:I3"
    sheet.merge_cells "J2:J3"
    sheet.merge_cells "K2:K3"
    sheet.merge_cells "L2:L3"
  end
  
  def self.add_rows sheet, project_id
    rows = VPollutionAmount.find_all_by_project_id project_id
    rows.each do |row|
      sheet.add_row [row.snap, row.snap_name, row.cont_source_name, row.cont_source_code, 
        row.x_coordinate, row.y_coordinate, row.diameter, row.height, row.line_speed.round(2), 
        row.temperature, row.chemical_element_cas, row.chemical_element_name, row.gs.round(4), row.ta.round(4)]
    end
  end

end