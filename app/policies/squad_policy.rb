class SquadPolicy < ApplicationPolicy
  def show?
    true
  end

  def show_members?
    member?
  end

  def invite_member?
    coach?
  end

  def edit?
    update?
  end

  def update?
    coach?
  end

  def coach?
    record.coach_member.user_id == user.id
  end

  def member?
    record.squad_members.pluck(:user_id).include?(user.id)
  end
end
