class Types::ScoreChangeType < Types::BaseObject
  description 'A score change'
  field :score, String, null: false
  field :from, Int, null: true
  field :to, Int, null: false
end
