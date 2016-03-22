class ContractDecorator < Draper::Decorator
  delegate_all
  decorates_association :user

  def number_and_fullname
    return object.number if user.try(:fullname).blank?
    [object.number, '(', user.fullname, ')'].join
  end
end
