require 'test_helper'

class Users::NicknamesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = users(:zinedine)
    @other_user = users(:diego)
  end

  test 'user cannot edit nickname of other' do
    sign_in @user

    assert_raises(Pundit::NotAuthorizedError) {
      get edit_user_nickname_path(@other_user)
    }
  end

  test 'user cannot update nickname of other' do
    sign_in @user

    assert_no_changes '@other_user.nickname' do
      assert_raises(Pundit::NotAuthorizedError) {
        patch user_nickname_path(@other_user), params: {
          user: {
            nickname: 'Hijack!'
          }
        }
      }
      @other_user.reload
    end
  end
end
