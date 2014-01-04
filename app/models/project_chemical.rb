class ProjectChemical < ActiveRecord::Base
  
  attr_accessible :project_id, :chemical_id, :snap_id, :amount, :contamination_source_id, :working_time
  attr_accessor :snap_snap, :snap_name, :chemical_name
  
  validates :project_id, :chemical_id, :snap_id, :amount, :contamination_source_id, :working_time, :presence => true
  validates_numericality_of :amount, :working_time
  
  belongs_to :chemical 
  belongs_to :snap 
  belongs_to :contamination_source
  belongs_to :project
  
end