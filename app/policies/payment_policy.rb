class PaymentPolicy < AdminPolicy
  def index?
    user.admin? || user.master?
  end

  def show?
    user.admin? || user.master?
  end

  def create?
    user.admin? || user.master?
  end

  def update?
    user.admin? || user.master?
  end

  def confirm?
    user.admin? || user.master?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
