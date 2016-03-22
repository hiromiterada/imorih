class UserDecorator < Draper::Decorator
  delegate_all

  def fullname
    [object.lastname, object.firstname].join(' ')
  end

  def welcome
    if fullname.present?
      name = fullname
    else
      name = object.email
    end
    I18n.t('views.welcome', name: name)
  end
end
