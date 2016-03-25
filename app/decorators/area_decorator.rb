class AreaDecorator < Draper::Decorator
  delegate_all

  def display_name
    ['No.', object.name].join
  end
end
