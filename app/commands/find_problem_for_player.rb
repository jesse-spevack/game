# typed: strict

module Commands
  class FindProblemForPlayer < Commands::Base
    extend T::Sig

    sig do
      params(player: Player, level: T.nilable(Integer)).returns(Problem)
    end
    def call(player:, level: nil)
      level ||= player.level

      player_problem_aggregate = T.let(
        PlayerProblemAggregate.joins(:problem)
        .where(player: player, retired: false)
        .where("problems.level = ?", level)
        .order(priority: :asc)
        .limit(1)
        .first,
        PlayerProblemAggregate
      )

      T.must(player_problem_aggregate.problem)
    end
  end
end
