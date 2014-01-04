class ChemicalElement < ActiveRecord::Base
  
  attr_accessible :chemical_id, :group_element_id, :max_percent
  attr_accessor :code, :name, :group_name
  
  validates :chemical_id, :group_element_id, :max_percent, :presence => true
  validates_numericality_of :max_percent
  
  belongs_to :chemical
  belongs_to :group_element
  
end