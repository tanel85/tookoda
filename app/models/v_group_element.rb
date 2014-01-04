class VGroupElement < ActiveRecord::Base
  
  self.primary_key = "id"
  
  attr_accessible :cas, :name, :group_name
  
end