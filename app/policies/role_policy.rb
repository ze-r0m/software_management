class RolePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.none unless user
      return scope.all if user.admin? || user.moderator?
    end
  end

  def show?    = user.admin_or_moderator?
  def index?   = show?
  def create?  = user.admin?
  def update?  = user.admin?
  def destroy? = user.admin?
end
