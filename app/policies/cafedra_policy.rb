class CafedraPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.none unless user

      if user.admin?
        scope.all # Админ видит всё, включая удалённые
      else
        scope.where(deleted_at: nil) # Остальные — только активные
      end
    end
  end

  def show?         = user.admin_or_moderator?
  def index?        = show?
  def create?       = user.admin_or_moderator?
  def update?       = user.admin_or_moderator?
  def destroy?      = user.admin?
  def soft_delete?  = user.admin_or_moderator?
  def restore?      = user.admin?
end