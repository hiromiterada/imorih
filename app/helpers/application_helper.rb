module ApplicationHelper
  def welcome_message
    if user_signed_in?
      name = current_user.decorate.fullname_or_email
    else
      name = I18n.t('views.guest')
    end
    I18n.t('views.welcome', name: name)
  end

  def money(money)
    return if money.blank?
    I18n.t('views.money_unit', money: money)
  end

  def money_per_month(money)
    return if money.blank?
    I18n.t('views.money_per_month', money: money)
  end
end
