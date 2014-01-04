class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end
  
  def create
    @group = Group.create(params[:group])
    if !@group.errors.any?
      flash[:notice] = "Grupp #{@group.name} on lisatud."
      redirect_to groups_path
    else
      @groups = Group.all
      render :index
    end
  end
end
