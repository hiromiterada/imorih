class ParkingsController < ApplicationController

  def index
    @parkings = Parking.publics.page(params[:page]).decorate
  end

  def show
    @parking = Parking.find_by(canonical_name: params[:canonical_name]).decorate
  end
end
