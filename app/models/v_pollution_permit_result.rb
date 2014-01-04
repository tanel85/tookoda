class VPollutionPermitResult < ActiveRecord::Base

  attr_accessible :project_id, :chemical_name, :chemical_element_name, :ta, :gs, :mgcm3
  
end