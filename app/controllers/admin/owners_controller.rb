class Admin::OwnersController < ApplicationController
  before_action :set_owner, only: [:show, :edit, :update, :destroy]

  def index
    @owners = Owner.order('created_at DESC').page(params[:page]).decorate
  end

  def show
  end

  def new
    @owner = Owner.new
  end

  def edit
  end

  def create
    @owner = Owner.new(owner_params)
    if @owner.save
      redirect_to admin_owners_url,
        notice: t('views.messages.successfully_created')
    else
      render :new
    end
  end

  def update
    if @owner.update(owner_params)
      redirect_to admin_owners_url,
        notice: t('views.messages.successfully_updated')
    else
      render :edit
    end
  end

  def destroy
    @owner.destroy
    redirect_to admin_owners_url,
      notice: t('views.messages.successfully_destroyed')
  end

  private

  def set_owner
    @owner = Owner.find(params[:id]).decorate
  end

  def owner_params
    params.require(:owner).permit(:name, :email, :address, :phone, :signature)
  end
end
