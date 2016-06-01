class ParkingPolicy < AdminPolicy
  def index?
    user.admin? || user.master?
  end

  def show?
    user.admin? || ( user.master? &&
      user.owners.include?(record.owner) )
  end

  def create?
    user.admin? || user.master?
  end

  def update?
    user.admin? || ( user.master? &&
      user.owners.include?(record.owner) )
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
