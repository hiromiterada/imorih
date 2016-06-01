class ParkingDecorator < Draper::Decorator
  delegate_all
  decorates_associations :areas

  def name_and_code
    [object.name, '(', object.code, ')'].join
  end

  def occupancy
    if object.vacancies.count == 0
      Parking.human_attribute_name(:occupied)
    else
      Parking.human_attribute_name(:vacant)
    end
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
