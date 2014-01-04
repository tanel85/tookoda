class ProjectsController < ApplicationController
  
  autocomplete :chemical, :name, :full => true
  autocomplete :snap, :name, :full => true, :extra_data => [:snap]
  
  def index
    @projects = Project.all
  end
  
  def create
    @project = Project.create(params[:project])
    if !@project.errors.any?
      flash[:notice] = "Asutus #{@project.name} on lisatud."
      redirect_to projects_path
    else
      @projects = Project.all
      render :index
    end
  end
  
  def project_chemicals
    @project_id = params[:id]
    @projectChemicals = ProjectChemical.find_all_by_project_id @project_id
  end
  
  def create_project_chemical
    projectChemicalParams = params[:projectChemical]
    @chemical_id = params[:chemical_id]
    @snap_id = params[:snap_id]
    @project_id = params[:project_id]
    @projectChemical = ProjectChemical.new
    @projectChemical.chemical_id = @chemical_id
    @projectChemical.snap_id = @snap_id
    @projectChemical.project_id = @project_id
    fillAttributes @projectChemical, projectChemicalParams
    @projectChemical.save
    if !@projectChemical.errors.any?
      redirect_to project_chemicals_project_path(@project_id)
    else
      @projectChemicals = ProjectChemical.find_all_by_project_id @project_id
      render :project_chemicals
    end
  end
  
  def fillAttributes projectChemical, projectChemicalParams
    projectChemical.amount = projectChemicalParams['amount']
    projectChemical.working_time = projectChemicalParams['working_time']
    projectChemical.snap_snap = projectChemicalParams['snap_snap']
    projectChemical.snap_name = projectChemicalParams['snap_name']
    projectChemical.contamination_source_id = projectChemicalParams['contamination_source_id']
    projectChemical.chemical_name = projectChemicalParams['chemical_name']
  end 
  
  def calculate
    @project_id = params[:id]
    @pollPermRows = VPollutionPermitResult.find_all_by_project_id @project_id
  end

end
