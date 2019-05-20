module Types
  class MutationType < Types::BaseObject
    field :update_prediction, mutation: Mutations::UpdatePrediction
  end
end
