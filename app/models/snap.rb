class Snap < ActiveRecord::Base
  
  attr_accessible :snap, :name
  
  validates :snap, :name, :presence => true
  
  has_many :project_chemicals
  
end