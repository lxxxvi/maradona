require 'test_helper'

class UpdateRankingsServiceTest < ActiveSupport::TestCase
  test 'returns ranking for all users' do
    service = UpdateRankingsService.new
    user = users(:diego)

    assert_changes 'user.ranking_position', from: 0, to: 1 do
      service.run!
      user.reload
    end
  end
end
