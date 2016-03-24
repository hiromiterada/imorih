class ParkingsController < ApplicationController

  def index
    @parkings = Parking.all
  end

  def show
    @parking = Parking.find_by canonical_name: params[:canonical_name]
  end
end
