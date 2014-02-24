class Project < ActiveRecord::Base
  
  attr_accessible :name
  
  validates :name, :presence => true
  
  has_many :contamination_sources, dependent: :destroy
  has_many :project_chemicals, dependent: :destroy
  
  def self.find_project_name id
    Project.where(:id => id).pluck(:name)[0]
  end
  
end