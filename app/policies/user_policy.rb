class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.none unless user

      if user.role.name == 'admin'
        scope.all
      elsif user.role.name == 'moderator'
        scope.all
      else
        scope.where(id: user.id)
      end
    end
  end

  def index?
    user.role.name.in?(%w[admin moderator])
  end

  def show?
    user.role.name == 'admin' || record.id == user.id || (user.role.name == 'moderator')
  end

  def create?
    user.role.name == 'admin'
  end

  def update?
    user.role.name == 'admin' || record.id == user.id
  end

  def destroy?
    user.role.name == 'admin'
  end
end
