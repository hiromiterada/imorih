class AreaDecorator < Draper::Decorator
  delegate_all
  decorates_association :parking
  decorates_associations :contracts

  def display_name
    ['No.', object.name].join
  end

  def occupancy
    if object.unavailable? || object.contracts.in_process.present?
      Area.human_attribute_name(:occupied)
    else
      Area.human_attribute_name(:vacant)
    end
  end

  def contract_info
    if object.contracts.in_process.present?
      contract = object.contracts.in_process.first.decorate
      [Area.human_attribute_name(:contract_period),
        '(', contract.period, ')', ' ',contract.number_and_fullname].join
    else
      nil
    end
  end
end
