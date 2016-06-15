class ContractDecorator < Draper::Decorator
  delegate_all
  decorates_association :user
  decorates_associations :areas

  def code_and_fullname
    return object.code if user.try(:fullname).blank?
    [object.code, '(', user.fullname, ')'].join
  end

  def parking_name_and_area_names
    return if object.parking.blank?
    return object.parking.name if object.areas.blank?
    [object.parking.name, '(', areas.map(&:display_name).join(','), ')'].join
  end

  def period
    [l(object.date_signed), l(object.date_terminated)].join(' - ')
  end

  def kind_and_parking_name
    return object.enum_i18n(:kind) if object.leased_land?
    [object.enum_i18n(:kind), '-', parking_name_and_area_names].join
  end

  def last_payday
    return '-' if object.payments.blank?
    l(object.payments.newest.payday)
  end

  def color
    return 'info' unless object.active?
    return 'danger' if object.overdue?
    'default'
  end

  def rent_per_month
    return if object.rent.blank?
    h.t('views.money_per_month', money: object.rent)
  end

  def rent_per_year
    return if object.rent.blank?
    h.t('views.money_per_year', money: object.rent * 12)
  end

  def rent_per_month_and_per_year
    [rent_per_month, ' (', rent_per_year, ')'].join
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
