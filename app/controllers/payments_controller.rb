class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  def index
    if current_user.normal?
      @payments = Payment.search_user(current_user)
    else
      @payments = Payment.all
    end
  end

  def show
  end

  def new
    @contracts = Contract.all
    @contract = Contract.find(params[:contract_id]) if params[:contract_id]
    @payment = Payment.new
  end

  def edit
    @contracts = Contract.all
    @contract = @payment.contract
  end

  def create
    @payment = Payment.new(payment_params)
    if @payment.save
      redirect_to @payment, notice: 'Payment was successfully created.'
    else
      render :new
    end
  end

  def update
    if @payment.update(payment_params)
      redirect_to @payment, notice: 'Payment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @payment.destroy
    redirect_to payments_url, notice: 'Payment was successfully destroyed.'
  end

  private

  def set_payment
    @payment = Payment.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(
      :contract_id, :payday, :amount, :started_date, :ended_date,
      :message, :note)
  end
end
