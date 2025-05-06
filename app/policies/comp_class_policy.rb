class CompClassPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.none       unless user
      return scope.all if user.role.name == 'admin'
      return scope.all if user.role.name == 'moderator'
    end
  end

  def show?    = user.role.name.in?(%w[admin moderator])
  def index?   = show?
  def create?  = user.role.name == 'admin'
  def update?  = user.role.name == 'admin'
  def destroy? = user.role.name == 'admin'
end
