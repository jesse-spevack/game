# typed: strict

class Statistic < T::Struct
  extend T::Sig

  const :display_problem, String
  const :total_responses, Integer
  const :percent_correct, Integer
  const :min_time, Integer
  const :max_time, Integer
  const :average_time, Integer
end
