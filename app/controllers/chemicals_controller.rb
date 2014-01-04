class ChemicalsController < ApplicationController
  def index
    @chemicals = Chemical.all
  end
  
  def create
    @chemical = Chemical.create(params[:chemical])
    if !@chemical.errors.any?
      flash[:notice] = "Kemikaal #{@chemical.name} on lisatud."
      redirect_to chemicals_path
    else
      @chemicals = Chemical.all
      render :index
    end
  end
end
