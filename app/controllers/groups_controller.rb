class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end
  
  def create
    @group = Group.create(params[:group])
    if !@group.errors.any?
      redirect_to groups_path
    else
      @groups = Group.all
      render :index
    end
  end
  
  def group_elements
    @group_id = params[:id]
    @groupElements= GroupElement.find_all_by_group_id @group_id
  end
  
  def create_group_element
    groupElementParams = params[:groupElement]
    @group_id = params[:group_id]
    groupElementParams['group_id'] = @group_id  
    @groupElement = GroupElement.create(groupElementParams)
    if !@groupElement.errors.any?
      redirect_to group_elements_group_path(@group_id)
    else
      @groupElements= GroupElement.find_all_by_group_id @group_id
      render :group_elements
    end
  end
end
