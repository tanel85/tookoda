module ReportHelper

  def self.test_report
    p = Axlsx::Package.new
    p.workbook.add_worksheet(:name => "Pie Chart") do |sheet|
      sheet.add_row ["Simple Pie Chart"]
      %w(first second third).each { |label| sheet.add_row [label, rand(24)+1] }
      sheet.add_chart(Axlsx::Pie3DChart, :start_at => [0,5], :end_at => [10, 20], :title => "example 3: Pie Chart") do |chart|
        chart.add_series :data => sheet["B2:B4"], :labels => sheet["A2:A4"],  :colors => ['FF0000', '00FF00', '0000FF']
      end
    end
      #p.serialize('simple.xlsx')
    outstrio = StringIO.new
    p.use_shared_strings = true # Otherwise strings don't display in iWork Numbers
    outstrio.write(p.to_stream.read)
    outstrio.string
  end
  
  def self.xlsx_to_string axlsx_package
    outstrio = StringIO.new
    axlsx_package.use_shared_strings = true # Otherwise strings don't display in iWork Numbers
    outstrio.write(axlsx_package.to_stream.read)
    outstrio.string
  end
  
end