class ContaminationSourcesController < ApplicationController
  def index
    @project_id = params[:project_id]
    @contSources = ContaminationSource.find_all_by_project_id @project_id
  end
  
  def create
    contSourceParams = params[:contSource]
    @project_id = params[:project_id]
    contSourceParams['project_id'] = @project_id    
    @contSource = ContaminationSource.create(contSourceParams)
    if !@contSource.errors.any?
      flash[:notice] = "Saasteallikas #{@contSource.name} on lisatud."
      redirect_to contamination_sources_path(:project_id => @project_id)
    else
      @contSources = ContaminationSource.find_all_by_project_id @project_id
      render :index
    end
  end
end
