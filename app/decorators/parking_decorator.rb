class ParkingDecorator < Draper::Decorator
  delegate_all

  def name_and_code
    [object.name, '(', object.code, ')'].join
  end
end
