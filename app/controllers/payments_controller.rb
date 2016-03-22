class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  def index
    if current_user.normal?
      payments = Payment.search_user(current_user)
    else
      payments = Payment.all
    end
    @payments = payments.order('payday DESC').page(params[:page])
  end

  def show
  end

  def new
    @contracts = Contract.all
    @payment = Payment.new
    @payment.contract = Contract.find(params[:contract_id]) if params[:contract_id]
  end

  def edit
    @contracts = Contract.all
  end

  def create
    @contracts = Contract.all
    @payment = Payment.new(payment_params)
    if @payment.save
      redirect_to @payment,
        notice: t('views.messages.successfully_created')
    else
      render :new
    end
  end

  def update
    @contracts = Contract.all
    if @payment.update(payment_params)
      redirect_to @payment,
        notice: t('views.messages.successfully_updated')
    else
      render :edit
    end
  end

  def destroy
    @payment.destroy
    redirect_to payments_url,
      notice: t('views.messages.successfully_destroyed')
  end

  private

  def set_payment
    @payment = Payment.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(
      :contract_id, :payday, :amount, :date_started, :date_ended,
      :message, :note)
  end
end
