class Admin::OwnersController < ApplicationController
  before_action :set_owner, only: [:show, :edit, :update, :destroy]
  before_action :set_parameters, only: [:new, :edit, :create, :update]
  before_action :authenticate_user!
  before_action :pundit_auth
  before_action :verify_authorized

  def index
    @owners = Owner.order('created_at DESC').page(params[:page]).decorate
  end

  def show
  end

  def new
    @owner = Owner.new
    @owner.owner_users.build
  end

  def edit
    @owner.owner_users.build if @owner.owner_users.blank?
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

  def set_parameters
    @users = User.master.decorate
  end

  def owner_params
    params.require(:owner).permit(
      :name, :email, :address, :phone, :representative, :signature,
      owner_users_attributes: [:id, :user_id, :_destroy]
    )
  end

  def pundit_record
    @owner || Owner.new
  end
end
