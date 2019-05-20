class Mutations::UpdatePrediction < Mutations::BaseMutation
  # null true

  argument :game_id, ID, required: true
  argument :left_team_score, Int, required: true
  argument :right_team_score, Int, required: true

  field :prediction, Types::PredictionType, null: true
  field :errors, [String], null: false

  def resolve(game_id:, left_team_score:, right_team_score:)
    # TODO: context[:current_user]
    prediction = Prediction.find_or_initialize_by(game_id: game_id)
    prediction.left_team_score = left_team_score
    prediction.right_team_score = right_team_score

    if prediction.save!
      {
        prediction: prediction,
        errors: []
      }
    else
      {
        prediction: nil,
        errors: prediction.errors.full_messages
      }
    end
  end
end
