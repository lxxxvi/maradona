require 'test_helper'

class UserSearchServiceTest < ActiveSupport::TestCase
  test 'returns uninvited' do
    service = UserSearchService.new('diego', 'les-bleues')
    search_result = service.find_player_ids
    assert_equal 1, search_result.count
  end

  test 'returns uninvited by nickname' do
    service = UserSearchService.new('Michl', 'les-bleues')
    search_result = service.find_player_ids
    assert_equal 1, search_result.count
  end

  test 'does not return accepted' do
    service = UserSearchService.new('zine', 'les-bleues')
    search_result = service.find_player_ids
    assert_equal 0, search_result.count
  end

  test 'does not return invited' do
    service = UserSearchService.new('pele', 'les-bleues')
    search_result = service.find_player_ids
    assert_equal 0, search_result.count
  end

  test 'does not return deactived' do
    jordan = users(:jordan)
    les_bleues = squads(:les_bleues)
    jordan.deactivate!

    assert_not_includes les_bleues.squad_members, jordan, 'Prerequisite for this test is that MJ is not member of Les Bleues in any state'

    service = UserSearchService.new('jordan', 'les-bleues')
    search_result = service.find_player_ids
    assert_equal 0, search_result.count
  end

  test 'returns with multiple string elements' do
    service = UserSearchService.new('mi ba', 'les-bleues')
    search_result = service.find_player_ids
    assert_equal 1, search_result.count
    assert_equal 'michael-ballack-66666', search_result.first['player_id']
    assert_equal 'Michl Ballack', search_result.first['nickname']
  end
end
