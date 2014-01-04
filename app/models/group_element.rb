class GroupElement < ActiveRecord::Base
  
  attr_accessible :cas, :name, :group_id
  
  validates :cas, :name, :group_id, :presence => true
  
  belongs_to :group
  has_many :chemical_elements, dependent: :destroy
  has_many :chemicals, through: :chemical_elements
  
end