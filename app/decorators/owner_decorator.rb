class OwnerDecorator < Draper::Decorator
  delegate_all
  decorates_associations :users
end
