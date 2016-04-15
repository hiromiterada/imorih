class ParkingsController < ApplicationController

  def index
    @parkings = Parking.publics.page(params[:page]).decorate
  end

  def show
    @parking = Parking.find_by(canonical_name: params[:canonical_name]).decorate
    @hash = Gmaps4rails.build_markers([@parking]) do |p, marker|
      marker.lat p.latitude
      marker.lng p.longitude
      marker.infowindow p.name + ' (' + p.address + ')'
      marker.json({title: p.name})
    end
  end
end
