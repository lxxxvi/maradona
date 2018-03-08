require 'test_helper'

class SquadsControllerTest < ActionDispatch::IntegrationTest

  setup do
    sign_in users(:diego)
  end

  test 'diego sees squads index' do
    get squads_path
    assert_response :success
  end

  test 'diego sees squad show of own' do
    get squad_path(squads(:fifa_100))
    assert_response :success
  end

  test 'diego sees squad show of foreign' do
    get squad_path(squads(:les_bleues))
    assert_response :success
  end

  test 'diego sees new squad form' do
    get squad_path(squads(:fifa_100))
    assert_response :success
  end

  test 'diego creates a new squad' do
    assert_difference 'Squad.count', 1 do
      post squads_path, params: { squad: { name: 'FIFA 200' } }
      follow_redirect!
      assert_response :success
    end

    squad = Squad.find_by(parameterized_name: 'fifa-200')
    assert_equal 1, squad.squad_members.count

    assert_not_nil squad.coach_member.invitation_sent_at
    assert_not_nil squad.coach_member.invitation_accepted_at
    assert_equal users(:diego), squad.coach_member.user
  end

  test 'diego tries to create new squad with an existing name' do
    assert_no_difference 'Squad.count' do
      post squads_path, params: { squad: { name: 'FIFA-100' } }
      assert_response :success
    end

    assert false
  end

  test 'diego sees edit form for own squads' do
    get edit_squad_path(squads(:fifa_100))
    assert_response :success
  end

  test 'diego does not see edit form for foreign squads' do
    assert_raises(Pundit::NotAuthorizedError) {
      get edit_squad_path(squads(:les_bleues))
    }
  end

  test 'diego updates own squad' do
    squad = squads(:fifa_100)
    assert_changes 'squad.name', from: 'Fifa 100', to: 'FIFA 100' do
      put squad_path(squad), params: { squad: { name: 'FIFA 100' } }
      follow_redirect!
      assert_response :success
      squad.reload
    end
  end

  test 'diego cannot update foreign squad' do
    squad = squads(:les_bleues)
    assert_no_changes 'squad.name' do
      assert_raises(Pundit::NotAuthorizedError) {
        put squad_path(squad), params: { squad: { name: 'Los Argentinos Azules' } }
      }
    end
  end

  test 'anonymuous sees none' do
    sign_out users(:diego)
    get squads_path
    assert_sign_in_required
  end

  private

  def assert_sign_in_required
    follow_redirect!
    assert_response :success
    assert_equal 'You need to sign in or sign up before continuing.', flash[:alert]
  end
end
