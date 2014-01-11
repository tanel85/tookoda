class VPollutionPermitResult < ActiveRecord::Base

  attr_accessible :project_id, :contamination_source_code, :group_name, :ta, :gs, :mgcm3
  
  def self.find_by_project project_id
    VPollutionPermitResult.where(:project_id => project_id).order('contamination_source_code, group_name')
  end
  
end