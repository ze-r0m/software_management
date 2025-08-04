class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.none unless user

      if user.admin? || user.moderator?
        scope.all
      else
        scope.where(id: user.id)
      end
    end
  end

  def index?
    user.admin_or_moderator?
  end

  def show?
    user.admin? || user.moderator? || record.id == user.id
  end

  def create?
    user.admin?
  end

  def update?
    user.admin? || record.id == user.id
  end

  def destroy?
    user.admin?
  end
end
