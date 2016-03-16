module EnumI18n
  extend ActiveSupport::Concern

  def enum_i18n(field)
    field = field.to_s unless field.is_a?(String)
    label = self.try(field)
    return "#{label}" if label.blank?
    scope = 'enums.' + self.class.to_s.downcase + '.' + field
    I18n.t(label.intern, scope: scope)
  end

  module ClassMethods
    def enum_i18n(field)
      field = field.to_s unless field.is_a?(String)
      labels = self.try(field.pluralize)
      return "#{labels}" if labels.blank?
      hash = Hash.new
      labels.each do |label, i|
        scope = 'enums.' + self.to_s.downcase + '.' + field
        hash[label] = I18n.t(label.intern, scope: scope)
      end
      hash
    end
  end
end
