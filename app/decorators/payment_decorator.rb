class PaymentDecorator < Draper::Decorator
  delegate_all
  decorates_association :contract

  def period
    if object.date_started.day == 1 &&
      object.date_ended == object.date_ended.end_of_month
      if object.date_started.year == object.date_ended.year &&
        object.date_started.month == object.date_ended.month
        return l(object.date_started, format: :short)
      else
        date_start = l(object.date_started, format: :short)
        date_end = l(object.date_ended, format: :short)
      end
    else
      date_start = l(object.date_started)
      date_end = l(object.date_ended)
    end
    [date_start, date_end].join(' - ')
  end

  def link_to_edit
    if h.policy(object).update?
      h.link_to h.t('views.edit'),
        [:edit, :admin, object], class: 'btn btn-default'
    end
  end

  def link_to_destroy
    if h.policy(object).destroy?
      h.link_to h.t('views.delete'),
        [:admin, object], method: :delete, class: 'btn btn-danger',
        data: { confirm: h.t('views.messages.confirm')}
    end
  end
end
