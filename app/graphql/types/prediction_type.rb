class Types::PredictionType < Types::BaseObject
  description "One game's prediction"
  field :id, ID, null: false
  field :game, Types::GameType, null: false
  field :left_team_score, Int, null: true
  field :right_team_score, Int, null: true
  field :previous_score_changes, [Types::ScoreChangeType], null: true
end
