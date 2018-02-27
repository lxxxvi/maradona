class RankingController < ApplicationController
  def index
    @top_100 = User.ordered_by_ranking.limit(100)
  end
end
