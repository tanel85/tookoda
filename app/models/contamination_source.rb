class ContaminationSource < ActiveRecord::Base
  
  attr_accessible :name, :code, :diameter, :height, :temperature, :x_coordinate, :y_coordinate, :volume_rate, :project_id
  
  validates :name, :code, :temperature, :x_coordinate, :y_coordinate, :volume_rate, :project_id, :presence => true
  validates_numericality_of :diameter, :allow_nil => true
  validates_numericality_of :height, :allow_nil => true
  validates_numericality_of :temperature, :allow_nil => true
  validates_numericality_of :x_coordinate, :allow_nil => true
  validates_numericality_of :y_coordinate, :allow_nil => true
  validates_numericality_of :volume_rate, :allow_nil => true
  
  belongs_to :project
  has_many :project_chemicals, dependent: :destroy
  
end