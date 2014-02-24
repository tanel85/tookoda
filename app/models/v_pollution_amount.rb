# encoding: UTF-8
class VPollutionAmount < ActiveRecord::Base

  attr_accessible :project_id, :snap, :snap_name, :cont_source_name, :cont_source_code, :x_coordinate, :y_coordinate,
    :diameter, :height, :line_speed, :temperature, :group_cas, :group_name, :gs, :ta
    
  def self.find_by_project project_id
    VPollutionAmount.where(:project_id => project_id).order('cont_source_code, group_name')
  end
  
  def self.add_sheet axlx_package, project_id
    row_style = axlx_package.workbook.styles.add_style :alignment => {:wrap_text => true}
    axlx_package.workbook.add_worksheet(:name => "Saasteainete heitkogused") do |sheet|
      add_header sheet, row_style
      add_rows sheet, row_style, project_id
      sheet.column_widths 8, 18, 14, 9, 9, 9, 11, 15, 10, 13, 12, 14, 9, 9
    end
  end
  
  def self.add_header sheet, row_style
    sheet.add_row ["Tegevusala, tehnoloogiaprotsess või seade", "", "Saasteallika ja väljuvate gaaside parameetrid",
       "", "", "", "", "", "", "", "Välisõhku eralduv saasteaine", "", "", ""], :style => row_style, :height => 40
    sheet.merge_cells "A1:B1"
    sheet.merge_cells "C1:J1"
    sheet.merge_cells "K1:N1"
    sheet.add_row ["SNAPi kood", "Nimetus", "Nimetus", "Nr plaanil või kaardil", "L-EST97 koordinaadid (pindallika korral koordinaadipaar - alumine vasak ja ülemine parem nurk)", 
      "", "Ava läbimõõt, m", "Väljumiskõrgus maapinnast, m", "Joonkiirus, m/s", "Temperatuur, °C", "CAS nr", "Nimetus", "Heitkogus", ""], :style => row_style
    sheet.merge_cells "E2:F2"
    sheet.merge_cells "M2:N2"
    sheet.add_row ["", "", "", "", "X", "Y", "", "", "", "", "", "", "hetkeline, g/s", "tonnides aastas"], :style => row_style
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
  
  def self.add_rows sheet, row_style, project_id
    rows = VPollutionAmount.find_by_project project_id
    rows.each do |row|
      sheet.add_row [row.snap, row.snap_name, row.cont_source_name, row.cont_source_code, 
        row.x_coordinate, row.y_coordinate, row.diameter, row.height, row.line_speed.round(2), 
        row.temperature, row.group_cas, row.group_name, row.gs.round(4), row.ta.round(4)], :style => row_style
    end
  end

end