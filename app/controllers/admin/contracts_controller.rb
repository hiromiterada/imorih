class Admin::ContractsController < ApplicationController
  before_action :set_contract, only: [:show, :edit, :update, :destroy]
  before_action :set_parameters, only: [:new, :edit, :create, :update]
  before_action :authenticate_user!
  before_action :pundit_auth
  before_action :verify_authorized

  def index
    @contracts = policy_scope(Contract).page(params[:page]).decorate
  end

  def show
  end

  def new
    @contract = Contract.new
    @contract.user = User.find(params[:user_id]) if params[:user_id]
    if params[:owner_id]
      @contract.owner = Owner.find(params[:owner_id])
    end
    if params[:parking_id]
      @contract.parking = Parking.find(params[:parking_id])
      @contract.owner = @contract.parking.owner
      @contract.kind = :monthly_parking
    end
  end

  def edit
  end

  def create
    @contract = Contract.new(contract_params)
    new_user = false
    if @contract.user.blank? && params[:new_user][:create] == '1'
      new_user = true
      @contract.user = User.create_without_confirmation
    end
    if @contract.save
      I18n.with_locale(current_user.locale.to_sym) do
        OwnerMailer.user_created(@contract, current_user).deliver if new_user
      end
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
    if current_user.admin?
      @owners = Owner.all
      @parkings = Parking.all
    else
      @owners = current_user.owners
      @parkings = Parking.by_master(current_user)
    end
  end

  def contract_params
    params.require(:contract).permit(
      :user_id, :owner_id, :parking_id, :code, :kind, :status,
      :rent, :date_signed, :date_terminated, :auto_updating, :note,
      :area_ids => []
    )
  end

  def pundit_record
    @contract || Contract.new
  end
end
