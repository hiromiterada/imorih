class Admin::ContractsController < ApplicationController
  before_action :set_contract, only: [:show, :edit, :update, :destroy]
  before_action :set_parameters, only: [:new, :edit, :create, :update]

  def index
    @contracts = Contract.order('created_at DESC').page(params[:page]).decorate
  end

  def show
  end

  def new
    @contract = Contract.new
    @contract.user = User.find(params[:user_id]) if params[:user_id]
  end

  def edit
  end

  def create
    @contract = Contract.new(contract_params)
    if @contract.save
      redirect_to admin_contracts_url,
        notice: t('views.messages.successfully_created')
    else
      render :new
    end
  end

  def update
    if @contract.update(contract_params)
      redirect_to admin_contracts_url,
        notice: t('views.messages.successfully_updated')
    else
      render :edit
    end
  end

  def destroy
    @contract.destroy
    redirect_to admin_contracts_url,
      notice: t('views.messages.successfully_destroyed')
  end

  private

  def set_contract
    @contract = Contract.find(params[:id]).decorate
  end

  def set_parameters
    @users = User.all.decorate
    @parkings = Parking.all
  end

  def contract_params
    params.require(:contract).permit(
      :user_id, :parking_id, :number, :kind, :status, :rent,
      :date_signed, :date_terminated, :auto_updating, :note,
      :area_ids => []
    )
  end
end
