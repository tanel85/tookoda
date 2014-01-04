class GroupElementsController < ApplicationController
  def index
    @group_id = params[:group_id]
    @groupElements= GroupElement.find_all_by_group_id @group_id
  end
  
  def create
    groupElementParams = params[:groupElement]
    @group_id = params[:group_id]
    groupElementParams['group_id'] = @group_id  
    @groupElement = GroupElement.create(groupElementParams)
    if !@groupElement.errors.any?
      flash[:notice] = "Grupi koostisosa #{@groupElement.name} on lisatud."
      redirect_to group_elements_path(:group_id => @group_id)
    else
      @groupElements= GroupElement.find_all_by_group_id @group_id
      render :index
    end
  end
end
