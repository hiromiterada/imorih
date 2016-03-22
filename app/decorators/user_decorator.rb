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

  def welcome
    if fullname.present?
      name = fullname
    else
      name = object.email
    end
    I18n.t('views.welcome', name: name)
  end

  def customer_code_and_fullname
    return object.customer_code if fullname.blank?
    [object.customer_code, '(', fullname, ')'].join
  end
end
