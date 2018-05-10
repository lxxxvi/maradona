require 'test_helper'

class AboutFlowsTest < ActionDispatch::IntegrationTest
  test 'guest sees about page' do
    get '/about'
    assert_response :success

    assert_select 'h2', 'What is TippKick?'
    assert_select 'h2', 'Privacy'
    assert_select 'h2', 'Who are we?'
    assert_select 'h2', 'Credits'
  end
end
