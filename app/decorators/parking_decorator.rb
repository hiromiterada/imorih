class ParkingDecorator < Draper::Decorator
  delegate_all
  decorates_associations :areas

  def name_and_code
    [object.name, '(', object.code, ')'].join
  end

  def occupancy
    if object.vacancies.count == 0
      status = Parking.human_attribute_name(:occupied)
    else
      status = Parking.human_attribute_name(:vacant)
    end
    [status, '(', object.vacancies.count, '/', object.capacity, ')'].join
  end
end
