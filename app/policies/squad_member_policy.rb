class SquadMemberPolicy < ApplicationPolicy
  def accept_invitation?
    acceptable?
  end

  def reject_invitation?
    rejectable?
  end

  def acceptable?
    record.invitation_accepted_at.nil?
  end

  def rejectable?
    acceptable? &&
    record.invitation_rejected_at.nil?
  end

  class Scope < Scope
    def resolve
      scope.of_user(user)
    end
  end
end
