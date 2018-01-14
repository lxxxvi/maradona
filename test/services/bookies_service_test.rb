require 'test_helper'

class BookiesServiceTest < ActiveSupport::TestCase
  test 'fetches row for user' do
    # todo
  end

  private

  def service
    BookiesService.new(users(:diego))
  end
end
