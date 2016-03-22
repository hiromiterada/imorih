class PaymentDecorator < Draper::Decorator
  delegate_all

  def period
    [object.date_started, object.date_ended].join(' - ')
  end
end
