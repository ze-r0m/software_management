class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.none       unless user
      return scope.all if user.role.name == 'admin'
      scope.none
    end
  end

  def index?   = user.role.name == 'admin'
  def show?    = user.role.name == 'admin'
  def create?  = user.role.name == 'admin'
  def update?  = user.role.name == 'admin'
  def destroy? = user.role.name == 'admin'
end
