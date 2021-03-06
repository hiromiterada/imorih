class PaymentPolicy < AdminPolicy
  def index?
    user.admin? || user.master?
  end

  def show?
    user.admin? || ( user.master? &&
      user.owners.include?(record.contract.owner) )
  end

  def create?
    user.admin? || user.master?
  end

  def update?
    user.admin? || ( user.master? &&
      user.owners.include?(record.contract.owner) )
  end

  def confirm?
    user.admin? || user.master?
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.by_master(user)
      end
    end
  end
end
