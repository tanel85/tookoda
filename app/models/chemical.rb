class Chemical < ActiveRecord::Base
  
  attr_accessible :name, :chemical_type, :loy, :hazard_class, :rh, :sp
  
  validates :name, :chemical_type, :loy, :presence => true
  validates_numericality_of :loy
  
  has_many :chemical_elements, dependent: :destroy
  has_many :project_chemicals
  has_many :group_elements, through: :chemical_elements
  
end