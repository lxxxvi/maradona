class Types::GameType < Types::BaseObject
  description 'A tournament game'
  field :id, ID, null: false
  field :tournament_stage, String, null: false
  field :kickoff_at, GraphQL::Types::ISO8601DateTime, null: false
  field :left_team, String, null: false
  field :right_team, String, null: false
  field :left_team_score, Int, null: true
  field :right_team_score, Int, null: true
end
