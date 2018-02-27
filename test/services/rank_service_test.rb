require 'test_helper'

class RankServiceTest < ActiveSupport::TestCase
  test 'returns ranking for all users' do
    service = RankService.new
    user = users(:diego)

    assert_changes 'user.ranking_position', from: 0, to: 1 do
      service.run!
      user.reload
    end
  end
end
