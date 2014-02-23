# encoding: UTF-8
class VChemicalUsage < ActiveRecord::Base

   attr_accessible :prch_id, :project_id, :chemical_name, :chemical_type, :loy, :amount, :hazard_class, :rh, :sp,
    :snap, :snap_name, :group_cas, :group_name, :ta, :gs, :cont_source_name 
    
  def self.find_by_project project_id
    VChemicalUsage.where(:project_id => project_id).order('prch_id, group_name')
  end
  
  def self.add_sheet axlx_package, project_id
    axlx_package.workbook.add_worksheet(:name => "Kemikaalide kasutamine") do |sheet|
      add_header sheet
      add_rows sheet, project_id
    end
  end
  
  def self.add_header sheet
    sheet.add_row ["Jrk nr", "Lahusteid sisaldav kemikaal", "", "", "Lahusteid sisaldava kemikaali kasutamine", 
      "", "", "", "", "", "Välisõhku eralduvate LOÜ-de heitkogus saasteainete kaupa", "", "", "", "Saasteallika nr plaanil või kaardil"]
    sheet.merge_cells "B1:D1"
    sheet.merge_cells "E1:J1"
    sheet.merge_cells "K1:N1"
    sheet.add_row ["", "Nimetus", "tüüp (WB – veepõhine; SB - lahustipõhine)", "LOÜ-de sisaldus, massi %", "kemikaali kogus aastas, tonni", 
      "Ohuklass (kategooria)", "R- või H- lause", "S- või P- lause", "Tegevusala või tehnoloogiaprotsess", "", "CAS nr", "nimetus", "heitkogus", "", ""]
    sheet.merge_cells "I2:J2"
    sheet.merge_cells "M2:N2"
    sheet.add_row ["", "", "", "", "", "", "", "", "SNAPi kood", "nimetus", "", "", "hetkeline, g/s", "tonnides aastas", ""]
    sheet.merge_cells "A1:A3"
    sheet.merge_cells "B2:B3"
    sheet.merge_cells "C2:C3"
    sheet.merge_cells "D2:D3"
    sheet.merge_cells "E2:E3"
    sheet.merge_cells "F2:F3"
    sheet.merge_cells "G2:G3"
    sheet.merge_cells "H2:H3"
    sheet.merge_cells "K2:K3"
    sheet.merge_cells "L2:L3"
    sheet.merge_cells "O1:O3"
  end
  
  def self.add_rows sheet, project_id
    rows = VChemicalUsage.where(:project_id => project_id).order(:prch_id)
    prch_id = nil
    row_number = 3
    rows.each_with_index do |row, index|
      if prch_id == row.prch_id
        sheet.add_row ["", "", "", "", "", "", "", "", "", "", row.group_cas, row.group_name, row.gs.round(4), row.ta.round(4), ""]
        sheet.merge_cells "A" + (index + 3).to_s + ":A" + (index + 4).to_s
        sheet.merge_cells "B" + (index + 3).to_s + ":B" + (index + 4).to_s
        sheet.merge_cells "C" + (index + 3).to_s + ":C" + (index + 4).to_s
        sheet.merge_cells "D" + (index + 3).to_s + ":D" + (index + 4).to_s
        sheet.merge_cells "E" + (index + 3).to_s + ":E" + (index + 4).to_s
        sheet.merge_cells "F" + (index + 3).to_s + ":F" + (index + 4).to_s
        sheet.merge_cells "G" + (index + 3).to_s + ":G" + (index + 4).to_s
        sheet.merge_cells "H" + (index + 3).to_s + ":H" + (index + 4).to_s
        sheet.merge_cells "I" + (index + 3).to_s + ":I" + (index + 4).to_s
        sheet.merge_cells "J" + (index + 3).to_s + ":J" + (index + 4).to_s
        sheet.merge_cells "O" + (index + 3).to_s + ":O" + (index + 4).to_s
      else
        prch_id = row.prch_id
        row_number += 1
        sheet.add_row [row_number - 3, row.chemical_name, (row.chemical_type == 'WB' ? 'WB - veepõhine' : 'SB - lahustipõhine'), 
          row.loy, row.amount, row.hazard_class, row.rh, row.sp, row.snap, row.snap_name, 
          row.group_cas, row.group_name, row.gs.round(4), row.ta.round(4), row.cont_source_name]
      end
    end
  end

end