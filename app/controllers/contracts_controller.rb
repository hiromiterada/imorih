class ContractsController < ApplicationController
  before_action :set_contract, only: [:show, :edit, :update, :destroy]

  def index
    @contracts = Contract.order('created_at DESC').page(params[:page]).decorate
  end

  def show
  end

  def new
    @users = User.all
    @contract = Contract.new
    @contract.user = User.find(params[:user_id]) if params[:user_id]
  end

  def edit
    @users = User.all
  end

  def create
    @users = User.all
    @contract = Contract.new(contract_params)
    if @contract.save
      redirect_to @contract,
        notice: t('views.messages.successfully_created')
    else
      render :new
    end
  end

  def update
    @users = User.all
    if @contract.update(contract_params)
      redirect_to @contract,
        notice: t('views.messages.successfully_updated')
    else
      render :edit
    end
  end

  def destroy
    @contract.destroy
    redirect_to contracts_url,
      notice: t('views.messages.successfully_destroyed')
  end

  private

  def set_contract
    @contract = Contract.find(params[:id]).decorate
  end

  def contract_params
    params.require(:contract).permit(
      :user_id, :number, :kind, :status, :rent, :date_signed,
      :date_terminated, :auto_updating, :note)
  end
end
