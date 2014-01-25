class ChemicalsController < ApplicationController
  
  autocomplete :v_group_element, :cas, :full => true, :extra_data => [:name, :group_name]
  
  def index
    @chemicals = Chemical.all
  end
  
  def create
    @chemical = Chemical.create(params[:chemical])
    if !@chemical.errors.any?
      redirect_to chemicals_path
    else
      @chemicals = Chemical.all
      render :index
    end
  end
  
  def chemical_elements
    @chemical_id = params[:id]
    @chemicalElements = ChemicalElement.find_all_by_chemical_id @chemical_id
  end
  
  def create_chemical_element
    chemicalElementParams = params[:chemicalElement]
    @chemical_id = params[:chemical_id]
    @group_element_id = params[:group_element_id]
    @chemicalElement = ChemicalElement.new
    @chemicalElement.chemical_id = @chemical_id
    @chemicalElement.group_element_id = @group_element_id
    fillAttributes @chemicalElement, chemicalElementParams
    @chemicalElement.save
    if !@chemicalElement.errors.any?
      redirect_to chemical_elements_chemical_path(@chemical_id)
    else
      @chemicalElements = ChemicalElement.find_all_by_chemical_id @chemical_id
      render :chemical_elements
    end
  end
  
  def fillAttributes chemicalElement, chemicalElementParams
    chemicalElement.max_percent = chemicalElementParams['max_percent']
    chemicalElement.code = chemicalElementParams['code']
    chemicalElement.name = chemicalElementParams['name']
    chemicalElement.group_name = chemicalElementParams['group_name']
  end
end
