class ContractDecorator < Draper::Decorator
  delegate_all
  decorates_association :user
  decorates_associations :areas

  def number_and_fullname
    return object.number if user.try(:fullname).blank?
    [object.number, '(', user.fullname, ')'].join
  end

  def parking_name_and_area_names
    return if object.parking.blank?
    return object.parking.name if object.areas.blank?
    [object.parking.name, '(', areas.map(&:display_name).join(','), ')'].join
  end

  def period
    [object.date_signed, object.date_terminated].join(' - ')
  end
end
