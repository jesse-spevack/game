# typed: strict

module Commands
  class GetPlayersLastRound < Commands::Base
    extend T::Sig

    class Result < T::Struct
      const :last_problem, T.nilable(Problem)
      const :player_was_just_wrong, T::Boolean
    end

    sig do
      params(player: Player)
        .returns(Result)
    end
    def call(player:)
      last_response = T.let(player.responses.order(completed_at: :desc).first, T.nilable(Response))
      last_problem = T.let(last_response&.problem, T.nilable(Problem))
      player_was_just_wrong = T.let(last_response && !last_response.correct? && T.let(Time.at(last_response.completed_at), Time).after?(30.seconds.ago), T.nilable(T::Boolean))

      Result.new(
        last_problem: last_problem,
        player_was_just_wrong: !!player_was_just_wrong
      )
    end
  end
end
