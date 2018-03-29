require 'test_helper'

class Admin::MatchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @group_stage_rus_ksa = matches(:match_rus_ksa)
    @rus = teams(:team_rus)
    @ksa = teams(:team_ksa)
    @kazan_arena = venues(:venue_kazan_arena)
  end
  test 'cannot get admin matches if not signed in' do
    get admin_matches_path
    follow_redirect!
    assert_response :success

    assert_equal 'Please sign in', flash[:notice]
  end

  test 'cannot get admin matches if signed in with user' do
    sign_in users(:pele)
    get admin_matches_path
    follow_redirect!
    assert_response :success

    assert_equal 'Please sign in', flash[:notice]
  end

  test 'get admin matches' do
    sign_in_admin

    get admin_matches_path
    assert_response :success
  end

  test 'get admin match' do
    sign_in_admin

    get admin_matches_path(@group_stage_rus_ksa)
    assert_response :success
  end

  test 'updates admin match' do
    sign_in_admin

    get edit_admin_match_path(@group_stage_rus_ksa)
    assert_response :success

    put admin_match_path(@group_stage_rus_ksa), params: {
      match: {
        phase: 'group_stage',
        left_team_id: @rus.id,
        right_team_id: @ksa.id,
        venue_id: @kazan_arena.id,
        "kickoff_at(1i)" => '2018',
        "kickoff_at(2i)" => '3',
        "kickoff_at(3i)" => '3',
        "kickoff_at(4i)" => '3',
        "kickoff_at(5i)" => '3',
        left_team_score: '8',
        right_team_score: '9'
      }
    }
    follow_redirect!
    assert_response :success

    @group_stage_rus_ksa.reload
    assert_equal 'Kazan Arena', @group_stage_rus_ksa.venue.name
    assert_equal 8, @group_stage_rus_ksa.left_team_score
    assert_equal 9, @group_stage_rus_ksa.right_team_score
    assert_equal DateTime.new(2018, 3, 3, 3, 3, 0, 0), @group_stage_rus_ksa.kickoff_at
  end

  test 'create admin match' do
    sign_in_admin

    get new_admin_match_path
    assert_response :success

    assert_difference -> { Match.count } do
      post admin_matches_path, params: {
        match: {
          phase: 'round_of_sixteen',
          left_team_id: @rus.id,
          right_team_id: @ksa.id,
          venue_id: @kazan_arena.id,
          "kickoff_at(1i)" => '2018',
          "kickoff_at(2i)" => '4',
          "kickoff_at(3i)" => '4',
          "kickoff_at(4i)" => '4',
          "kickoff_at(5i)" => '4',
          left_team_score: '',
          right_team_score: ''
        }
      }
    end
    follow_redirect!
    assert_response :success

    round_of_sixteen_rus_ksa = Match.last
    assert_equal 'Kazan Arena', round_of_sixteen_rus_ksa.venue.name
    assert_nil round_of_sixteen_rus_ksa.left_team_score
    assert_nil round_of_sixteen_rus_ksa.right_team_score
    assert_equal DateTime.new(2018, 4, 4, 4, 4, 0, 0), round_of_sixteen_rus_ksa.kickoff_at
  end
end
