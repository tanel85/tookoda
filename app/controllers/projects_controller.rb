class ProjectsController < ApplicationController
  
  autocomplete :chemical, :name, :full => true
  autocomplete :snap, :name, :full => true, :extra_data => [:snap]
  
  def index
    @projects = Project.all
  end
  
  def create
    @project = Project.create(params[:project])
    if !@project.errors.any?
      redirect_to projects_path
    else
      @projects = Project.all
      render :index
    end
  end
  
  def destroy
    project_id = params[:id]
    project = Project.find(project_id)
    project.destroy    
    flash[:notice] = "Projekt '#{project.name}' kustutati."
    redirect_to projects_path
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
  
  def destroy_project_chemical
    project_chemical_id = params[:id]
    project_chemical = ProjectChemical.find(project_chemical_id)
    project_chemical.destroy
    flash[:notice] = "Saasteallika kemikaal kustutati."
    redirect_to project_chemicals_project_path project_chemical.project_id
  end
  
  def fillAttributes projectChemical, projectChemicalParams
    projectChemical.amount = projectChemicalParams['amount']
    projectChemical.working_time = projectChemicalParams['working_time']
    projectChemical.snap_snap = projectChemicalParams['snap_snap']
    projectChemical.snap_name = projectChemicalParams['snap_name']
    projectChemical.contamination_source_id = projectChemicalParams['contamination_source_id']
    projectChemical.chemical_name = projectChemicalParams['chemical_name']
  end
  
  def contamination_sources
    @project_id = params[:id]
    @contSources = ContaminationSource.find_all_by_project_id @project_id
  end
  
  def create_contamination_source
    contSourceParams = params[:contSource]
    @project_id = params[:project_id]
    contSourceParams['project_id'] = @project_id    
    @contSource = ContaminationSource.create(contSourceParams)
    if !@contSource.errors.any?
      redirect_to contamination_sources_project_path(@project_id)
    else
      @contSources = ContaminationSource.find_all_by_project_id @project_id
      render :contamination_sources
    end
  end
  
  def destroy_contamination_source
    cont_source_id = params[:id]
    cont_source = ContaminationSource.find(cont_source_id)
    cont_source.destroy
    flash[:notice] = "Saasteallikas '#{cont_source.name}' kustutati."
    redirect_to contamination_sources_project_path cont_source.project_id
  end
  
  def calculate
    @project_id = params[:id]
    pollPermRows = VPollutionPermitResult.find_by_project @project_id
    @pollPermRowsMap = Hash.new
    @totalRows = Hash.new
    @totalRow = PollutionPermitTotalRow.create
    pollPermRows.each do |pollPermRow|
      if @pollPermRowsMap.has_key? pollPermRow.contamination_source_code
        @pollPermRowsMap[pollPermRow.contamination_source_code] << pollPermRow
      else
        @pollPermRowsMap[pollPermRow.contamination_source_code] = [pollPermRow]
      end
      @totalRow.gs += pollPermRow.gs
      @totalRow.ta += pollPermRow.ta
      @totalRow.mgcm3 += pollPermRow.mgcm3
      row = nil
      if @totalRows.has_key? pollPermRow.contamination_source_code
        row = @totalRows[pollPermRow.contamination_source_code]
      else
        row = PollutionPermitTotalRow.create
        @totalRows[pollPermRow.contamination_source_code] = row
      end
      row.gs += pollPermRow.gs
      row.ta += pollPermRow.ta
      row.mgcm3 += pollPermRow.mgcm3
    end
  end
  
  def print
    calculate
    p = Axlsx::Package.new
    VPollutionAmount.add_sheet p, @project_id
    VChemicalUsage.add_sheet p, @project_id
    file = ReportHelper.xlsx_to_string p
    send_data file, :filename=>"report.xlsx"
  end

end
