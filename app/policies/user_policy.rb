class UserPolicy < AdminPolicy
  def index?
    user.admin? || user.master?
  end

  def show?
    user.admin? || ( user.master? &&
      user.owners.include?(record.contracts.first.owner) )
  end

  def create?
    user.admin?
  end

  def update?
    user.admin? || ( user.master? &&
      user.owners.include?(record.contracts.first.owner) )
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
