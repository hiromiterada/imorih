module BooleanI18n
  extend ActiveSupport::Concern

  def boolean_i18n(field)
    field = field.to_s unless field.is_a?(String)
    label = self.try(field)
    return "#{label}" unless label == true || label == false
    I18n.t(yes_or_no(label), scope: 'views.boolean')
  end

  private

  def yes_or_no(value)
    value = false unless value == true || value == false
    value ? 'yes' : 'no'
  end
end
