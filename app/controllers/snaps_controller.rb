# encoding: UTF-8
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
  
  def destroy
    snap_id = params[:id]
    snap = Snap.find(snap_id)
    if !snap.project_chemicals.empty?
      flash[:warning] = "Snapi '#{snap.name}' ei saa kustutada, kuna see on kasutuses ühes või mitmes projektis. Eemalda see kõigepealt projektidest."
      @snaps = Snap.all
      render :index
    else
      snap.destroy
      flash[:notice] = "Snap '#{snap.name}' kustutati."
      redirect_to snaps_path
    end
  end
end
