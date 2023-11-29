# typed: strict

# An object that encapsultes the input needed to create a response from a request.
class ResponseInput < T::Struct
  extend T::Sig

  const :problem, T.nilable(Problem)
  const :player, T.nilable(Player)
  const :solution, T.nilable(Integer)
  const :response, Integer
  const :started_at, Integer
  const :completed_at, Integer

  sig { params(params: ActionController::Parameters).returns(ResponseInput) }
  def self.new_from_params(params:)
    problem = T.let(Problem.find_by!(id: params[:problem_id]), Problem)
    player = T.let(Player.find_by!(id: params[:player_id]), Player)
    response = T.let(params[:response], String).to_i
    started_at = T.let(params[:started_at], String).to_i

    new(
      problem: problem,
      player: player,
      solution: problem.solution,
      response: response,
      started_at: started_at,
      completed_at: Time.now.to_i
    )
  end
end
