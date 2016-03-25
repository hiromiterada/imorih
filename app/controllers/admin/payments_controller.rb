class Admin::PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]
  before_action :set_parameters, only: [:new, :edit, :create, :update]
  before_filter :authenticate_user!

  def index
    @payments = Payment.all.order('payday DESC').page(params[:page]).decorate
  end

  def show
  end

  def new
    @payment = Payment.new
    @payment.contract = Contract.find(params[:contract_id]) if params[:contract_id]
  end

  def edit
  end

  def create
    @payment = Payment.new(payment_params)
    if @payment.save
      redirect_to admin_payments_url,
        notice: t('views.messages.successfully_created')
    else
      render :new
    end
  end

  def update
    if @payment.update(payment_params)
      redirect_to admin_payments_url,
        notice: t('views.messages.successfully_updated')
    else
      render :edit
    end
  end

  def destroy
    @payment.destroy
    redirect_to admin_payments_url,
      notice: t('views.messages.successfully_destroyed')
  end

  private

  def set_payment
    @payment = Payment.find(params[:id]).decorate
  end

  def set_parameters
    @contracts = Contract.all.decorate
  end

  def payment_params
    params.require(:payment).permit(
      :contract_id, :payday, :amount, :date_started, :date_ended,
      :message, :note
    )
  end
end
