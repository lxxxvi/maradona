require 'test_helper'

class SquadTest < ActiveSupport::TestCase
  test 'invitation key is set after creating a squad' do
    squad = Squad.new(name: 'World Champions')
    squad.save
    squad.reload

    refute_nil squad.invitation_key, 'invitation key should have been created'
  end
end
