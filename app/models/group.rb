class Group < ActiveRecord::Base
  
  attr_accessible :cas, :name, :carbon_content
  
  validates :cas, :name, :carbon_content, :presence => true
  validates_numericality_of :carbon_content
  
  has_many :group_elements, dependent: :destroy
  
end