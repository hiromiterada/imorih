class PaymentDecorator < Draper::Decorator
  delegate_all
  decorates_association :contract

  def period
    [l(object.date_started), l(object.date_ended)].join(' - ')
  end
end
