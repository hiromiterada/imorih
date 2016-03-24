class Admin::ParkingsController < ApplicationController
  before_action :set_parking, only: [:show, :edit, :update, :destroy]

  def index
    @parkings = Parking.order('created_at DESC').page(params[:page]).decorate
  end

  def show
  end

  def new
    @managements = Management.all
    @parking = Parking.new
    @parking.management = Management.find(params[:management_id]) if params[:management_id]
    @parking.areas.build
  end

  def edit
    @managements = Management.all
    @parking.areas.build if @parking.areas.blank?
  end

  def create
    @managements = Management.all
    @parking = Parking.new(parking_params)
    if @parking.save
      redirect_to admin_parkings_url,
        notice: t('views.messages.successfully_created')
    else
      render :new
    end
  end

  def update
    @managements = Management.all
    if @parking.update(parking_params)
      redirect_to admin_parkings_url,
        notice: t('views.messages.successfully_updated')
    else
      render :edit
    end
  end

  def destroy
    @parking.destroy
    redirect_to admin_parkings_url,
      notice: t('views.messages.successfully_destroyed')
  end

  private

  def set_parking
    @parking = Parking.find(params[:id]).decorate
  end

  def parking_params
    params.require(:parking).permit(
      :management_id, :name, :code, :canonical_name, :address,
      :latitude, :longitude, :description, :price, :message, :cautions,
      areas_attributes: [
      :id, :parking_id, :name, :status, :note, :_destroyi
      ]
    )
  end
end
