class UserPolicy < AdminPolicy
  def show?
    user.admin? || ( user.master? &&
      user.owners.include?(record.contracts.first.owner) )
  end

  def update?
    user.admin? || ( user.master? &&
      user.owners.include?(record.contracts.first.owner) )
  end
end
