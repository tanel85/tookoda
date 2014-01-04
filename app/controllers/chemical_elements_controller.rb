class ChemicalElementsController < ApplicationController
  
  autocomplete :v_group_element, :cas, :full => true, :extra_data => [:name, :group_name]
  
  def index
    @chemical_id = params[:chemical_id]
    @chemicalElements = ChemicalElement.find_all_by_chemical_id @chemical_id
  end
  
  def create
    chemicalElementParams = params[:chemicalElement]
    @chemical_id = params[:chemical_id]
    @group_element_id = params[:group_element_id]
    @chemicalElement = ChemicalElement.new
    @chemicalElement.chemical_id = @chemical_id
    @chemicalElement.group_element_id = @group_element_id
    fillAttributes @chemicalElement, chemicalElementParams
    @chemicalElement.save
    if !@chemicalElement.errors.any?
      redirect_to chemical_elements_path(:chemical_id => @chemical_id)
    else
      @chemicalElements = ChemicalElement.find_all_by_chemical_id @chemical_id
      render :index
    end
  end
  
  def fillAttributes chemicalElement, chemicalElementParams
    chemicalElement.max_percent = chemicalElementParams['max_percent']
    chemicalElement.code = chemicalElementParams['code']
    chemicalElement.name = chemicalElementParams['name']
    chemicalElement.group_name = chemicalElementParams['group_name']
  end
   
end
