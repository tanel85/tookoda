class SnapsController < ApplicationController
  def index
    @snaps = Snap.all
  end
  
  def create
    @snap = Snap.create(params[:snap])
    if !@snap.errors.any?
      flash[:notice] = "SNAP #{@snap.name} on lisatud."
      redirect_to snaps_path
    else
      @snaps = Snap.all
      render :index
    end
  end
end
