class PollutionPermitTotalRow
  
  attr_accessor :ta, :gs, :mgcm3
  
  def self.create
    totalRow = PollutionPermitTotalRow.new
    totalRow.ta = 0
    totalRow.gs = 0
    totalRow.mgcm3 = 0
    totalRow
  end
  
end