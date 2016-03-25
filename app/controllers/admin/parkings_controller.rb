class Admin::ParkingsController < ApplicationController
  before_action :set_parking, only: [:show, :edit, :update, :destroy]
  before_action :set_parameters, only: [:new, :edit, :create, :update]

  def index
    @parkings = Parking.order('created_at DESC').page(params[:page]).decorate
  end

  def show
  end

  def new
    @parking = Parking.new
    @parking.owner = Owner.find(params[:owner_id]) if params[:owner_id]
    @parking.areas.build
  end

  def edit
    @parking.areas.build if @parking.areas.blank?
  end

  def create
    @parking = Parking.new(parking_params)
    if @parking.save
      redirect_to admin_parkings_url,
        notice: t('views.messages.successfully_created')
    else
      render :new
    end
  end

  def update
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

  def set_parameters
    @owners = Owner.all
  end

  def parking_params
    params.require(:parking).permit(
      :owner_id, :name, :code, :canonical_name, :address,
      :latitude, :longitude, :description, :price, :message, :cautions,
      areas_attributes: [
      :id, :parking_id, :name, :status, :note, :_destroy
      ]
    )
  end
end
