require 'simplecov'
SimpleCov.start 'rails'

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  fixtures :all

  def before_the_world_cup
    Time.new(2018, 1, 1, 0, 0, 0, 0)
  end

  def during_the_world_cup
    Time.new(2018, 6, 30, 0, 0, 0, 0)
  end
end

class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def sign_in_admin
    sign_in_admin_with_password('admin')
  end

  def sign_out_admin
    delete admin_sessions_path
  end

  def sign_in_admin_with_password(password)
    post admin_sessions_path, params: {
      session: {
        password: password
      }
    }
  end
end

class ActionController::TestCase
  include Devise::Test::ControllerHelpers
end
