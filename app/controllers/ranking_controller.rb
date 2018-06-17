class RankingController < ApplicationController
  def index
    @top_100_users  = User.ordered_by_ranking.limit(100)
    @top_100_squads = Squad.ordered_by_ranking.limit(100)
  end
end
