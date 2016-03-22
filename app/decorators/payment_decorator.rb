class PaymentDecorator < Draper::Decorator
  delegate_all
  decorates_association :contract

  def period
    [object.date_started, object.date_ended].join(' - ')
  end
end
