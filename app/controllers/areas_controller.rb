class AreasController < ApplicationController

  def index
    if parking = Parking.find_by(id: params[:parking_id])
      areas = parking.areas.actives.select(:id, :name)
    else
      areas = []
    end
    render json: areas
  end
end
