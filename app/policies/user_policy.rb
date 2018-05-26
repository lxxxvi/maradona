class UserPolicy < ApplicationPolicy
  def edit?
    record == user
  end

  def update?
    edit?
  end
end
