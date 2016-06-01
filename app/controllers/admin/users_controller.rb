class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :pundit_auth
  before_action :verify_authorized

  def index
    @users = User.order('created_at DESC').page(params[:page]).decorate
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    @user.skip_confirmation!
    if @user.save
      redirect_to admin_users_url,
        notice: t('views.messages.successfully_created')
    else
      render :new
    end
  end

  def update
    @user.skip_reconfirmation!
    if @user.update(user_params)
      redirect_to admin_users_url,
        notice: t('views.messages.successfully_updated')
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_url,
      notice: t('views.messages.successfully_destroyed')
  end

  private

  def set_user
    @user = User.find(params[:id]).decorate
  end

  def user_params
    params.require(:user).permit(
      :email, :password, :password_confirmation, :lastname, :firstname,
      :locale, :gender, :birthday, :address, :phone, :role,
      :customer_code, :send_of_dm
    )
  end

  def pundit_record
    @user || User.new
  end
end
