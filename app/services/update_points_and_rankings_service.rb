class UpdatePointsAndRankingsService
  attr_reader :match

  def initialize(match = nil)
    @match = match
  end

  def run!
    ActiveRecord::Base.transaction do
      UpdatePredictionsPointsService.new(match).run!
      UpdateUsersPointsService.new.run!
      UpdateUsersRankingsService.new.run!
      UpdateSquadsPointsService.new.run!
      UpdateSquadsRankingsService.new.run!
    end
  end
end
