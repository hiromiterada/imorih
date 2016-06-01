class PaymentDecorator < Draper::Decorator
  delegate_all
  decorates_association :contract

  def period
    [l(object.date_started), l(object.date_ended)].join(' - ')
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
        data: { confirm: t('views.messages.confirm')}
    end
  end
end
