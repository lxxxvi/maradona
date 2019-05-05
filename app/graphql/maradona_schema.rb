class MaradonaSchema < GraphQL::Schema
  max_complexity 100
  max_depth 10
  mutation(Types::MutationType)
  query(Types::QueryType)
end
