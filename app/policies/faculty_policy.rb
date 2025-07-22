class FacultyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.none unless user
      if user.role.name == 'admin'
        scope.all # Админ видит все (включая удалённые)
      else
        scope.where(deleted_at: nil) # Остальные видят только активные
      end
    end
  end

  def show?    = user.role.name.in?(%w[admin moderator])
  def index?   = show?
  def create?  = user.role.name =  user.role.name.in?(%w[admin moderator])
  def update?  = user.role.name =  user.role.name.in?(%w[admin moderator])
  def destroy? = user.role.name == 'admin'
  def soft_delete? =  user.role.name.in?(%w[admin moderator])
  def restore? =  user.role.name == 'admin'
end