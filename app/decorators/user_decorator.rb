class UserDecorator < Draper::Decorator
  delegate_all

  def fullname
    case object.locale
    when 'ja'
      [object.lastname, object.firstname].join(' ')
    else
      [object.firstname, object.lastname].join(' ')
    end
  end

  def fullname_or_email
    return fullname if fullname.present?
    object.email
  end

  def customer_code_and_fullname
    return object.customer_code if fullname.blank?
    [object.customer_code, '(', fullname, ')'].join
  end

  def owner_names
    object.owners.pluck(:name).join(',')
  end
end
