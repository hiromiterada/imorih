class Admin::PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]
  before_action :set_parameters, only: [:new, :edit, :create, :update, :confirm]
  before_action :authenticate_user!
  before_action :pundit_auth
  before_action :verify_authorized

  def index
    if params[:contract_id]
      contract = Contract.find(params[:contract_id])
      payments = contract.payments
    else
      payments = policy_scope(Payment)
    end
    @payments = payments.order('payday DESC').page(params[:page]).decorate
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
    if params[:edit]
      render :new
    elsif @payment.save
      if @payment.sent_mail && @payment.user.send_mail?
        I18n.with_locale(@payment.user.locale.to_sym) do
          CustomerMailer.payment_confirmation(@payment).deliver
        end
        notice = t('views.messages.successfully_sent_mail')
      else
        @payment.update(sent_mail: false)
        notice = t('views.messages.successfully_created')
      end
      redirect_to admin_payments_url, notice: notice
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

  def confirm
    @payment = Payment.new(payment_params).decorate
    render :new if @payment.invalid?
  end

  private

  def set_payment
    @payment = Payment.find(params[:id]).decorate
  end

  def set_parameters
    if current_user.admin?
      @contracts = Contract.all.decorate
    else
      @contracts = Contract.by_master(current_user).decorate
    end
  end

  def payment_params
    params.require(:payment).permit(
      :contract_id, :payday, :amount, :date_started, :date_ended,
      :message, :note, :sent_mail
    )
  end

  def pundit_record
    @payment || Payment.new
  end
end
