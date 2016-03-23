class Admin::ManagementsController < ApplicationController
  before_action :set_management, only: [:show, :edit, :update, :destroy]

  def index
    @managements = Management.order('created_at DESC').page(params[:page]).decorate
  end

  def show
  end

  def new
    @management = Management.new
  end

  def edit
  end

  def create
    @management = Management.new(management_params)
    if @management.save
      redirect_to admin_managements_url,
        notice: t('views.messages.successfully_created')
    else
      render :new
    end
  end

  def update
    if @management.update(management_params)
      redirect_to admin_managements_url,
        notice: t('views.messages.successfully_updated')
    else
      render :edit
    end
  end

  def destroy
    @management.destroy
    redirect_to admin_managements_url,
      notice: t('views.messages.successfully_destroyed')
  end

  private

  def set_management
    @management = Management.find(params[:id]).decorate
  end

  def management_params
    params.require(:management).permit(:name, :email, :address, :phone)
  end
end
