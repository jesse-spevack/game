# typed: strict

module Commands
  class LevelUpPlayer < Commands::Base
    extend T::Sig

    sig do
      params(player: Player).void
    end
    def call(player:)
      T.let(player.update(level: player.level + 1), T::Boolean)

      Commands::CreatePlayerProblemAggregatesForLevel.call(player: player, level: player.level)
    end
  end
end
