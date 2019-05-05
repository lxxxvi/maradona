module Types
  class QueryType < Types::BaseObject
    field :game, GameType, null: true do
      description 'Find a game by ID'
      argument :id, ID, required: true
    end

    field :games, [GameType], null: true do
      description 'All games in tournament'
    end

    def game(id:)
      Game.joins(:left_team, :right_team).find(id)
    end

    def games
      Game.ordered_by_kickoff
    end
  end
end
