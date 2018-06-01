module SquadHelper
  def squad_invitation_link(squad)
    squad_join_by_key_url(squad, squad.invitation_key)
  end
end
