# typed: strict

module Commands
  class GetPlayerProgress < Commands::Base
    extend T::Sig

    sig { params(player: Player).returns(Integer) }
    def call(player:)
      retired_count = T.let(PlayerProblemAggregate.joins(:problem)
        .where(player: player)
        .where(retired: true)
        .where("problems.level = ?", player.level).count, Integer)

      total_count = T.let(PlayerProblemAggregate.joins(:problem)
        .where(player: player)
        .where("problems.level = ?", player.level)
        .count, Integer)

      (retired_count * 100.0 / total_count * 100.0).to_i / 100
    end
  end
end
