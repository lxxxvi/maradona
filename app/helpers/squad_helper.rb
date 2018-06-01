module SquadHelper
  def squad_invitation_link(squad)
    join_by_key_url(squad.invitation_key)
  end
end
