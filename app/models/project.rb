class Project < ActiveRecord::Base
  
  attr_accessible :name
  
  validates :name, :presence => true
  
  has_many :contamination_sources, dependent: :destroy
  has_many :project_chemicals, dependent: :destroy
  
end