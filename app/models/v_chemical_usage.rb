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
    row_number = 0
    merge_start_index = 4
    rows.each_with_index do |row, index|
      if prch_id == row.prch_id
        sheet.add_row ["", "", "", "", "", "", "", "", "", "", row.group_cas, row.group_name, row.gs.round(4), row.ta.round(4), ""]
      else
        if index + 3 > merge_start_index
          sheet.merge_cells "A" + merge_start_index.to_s + ":A" + (index + 3).to_s
          sheet.merge_cells "B" + merge_start_index.to_s + ":B" + (index + 3).to_s
          sheet.merge_cells "C" + merge_start_index.to_s + ":C" + (index + 3).to_s
          sheet.merge_cells "D" + merge_start_index.to_s + ":D" + (index + 3).to_s
          sheet.merge_cells "E" + merge_start_index.to_s + ":E" + (index + 3).to_s
          sheet.merge_cells "F" + merge_start_index.to_s + ":F" + (index + 3).to_s
          sheet.merge_cells "G" + merge_start_index.to_s + ":G" + (index + 3).to_s
          sheet.merge_cells "H" + merge_start_index.to_s + ":H" + (index + 3).to_s
          sheet.merge_cells "I" + merge_start_index.to_s + ":I" + (index + 3).to_s
          sheet.merge_cells "J" + merge_start_index.to_s + ":J" + (index + 3).to_s
          sheet.merge_cells "O" + merge_start_index.to_s + ":O" + (index + 3).to_s
          puts "A" + merge_start_index.to_s + ":A" + (index + 3).to_s
        end
        prch_id = row.prch_id
        row_number += 1
        merge_start_index = index + 4
        sheet.add_row [row_number, row.chemical_name, (row.chemical_type == 'WB' ? 'WB - veepõhine' : 'SB - lahustipõhine'), 
          row.loy, row.amount, row.hazard_class, row.rh, row.sp, row.snap, row.snap_name, 
          row.group_cas, row.group_name, row.gs.round(4), row.ta.round(4), row.cont_source_name]
      end
    end
  end

end