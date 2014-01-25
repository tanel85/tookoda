class SnapsController < ApplicationController
  def index
    @snaps = Snap.all
  end
  
  def create
    @snap = Snap.create(params[:snap])
    if !@snap.errors.any?
      redirect_to snaps_path
    else
      @snaps = Snap.all
      render :index
    end
  end
end
