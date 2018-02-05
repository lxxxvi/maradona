require 'test_helper'

class MatchPredictionCollectionServiceTest < ActiveSupport::TestCase
  test 'fetches all matches for user' do
    assert_equal 4, service.matches_with_predictions.count
  end

  private

  def service
    MatchPredictionCollectionService.new(users(:diego))
  end
end
