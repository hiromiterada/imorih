class PaymentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @contracts = current_user.contracts.decorate
    @payments = Payment.by_user(current_user).order('payday DESC').page(params[:page]).decorate
  end
end
