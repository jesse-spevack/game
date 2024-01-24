# typed: strict

module Commands
  class FindProblemForPlayer < Commands::Base
    extend T::Sig

    sig do
      params(player: Player, level: T.nilable(Integer)).returns(Problem)
    end
    def call(player:, level: nil)
      level ||= player.level

      updated_at = PlayerProblemAggregate.where(player: player).maximum(:updated_at)

      if !PlayerProblemAggregate.joins(:problem).where(player: player).where("problems.level = ?", level).exists?
        # If the aggregates for the new level were not created asynchronously, create them now.
        CreatePlayerProblemAggregatesForLevel.call(player: player, level: level)
      end

      player_problem_aggregate_updated_at_timestamps = T.let(PlayerProblemAggregate.joins(:problem)
        .where(player: player, retired: false)
        .where("problems.level = ?", level)
        .pluck(:updated_at), T::Array[ActiveSupport::TimeWithZone])

      just_leveled = T.let(player_problem_aggregate_updated_at_timestamps.all? { |time| time == updated_at }, T::Boolean)

      if just_leveled
        priority = PlayerProblemAggregate.joins(:problem)
          .where(player: player, retired: false)
          .where("problems.level = ?", level)
          .minimum(:priority)

        player_problem_aggregate = T.let(
          PlayerProblemAggregate.joins(:problem)
          .where(player: player, retired: false, priority: priority)
          .where("problems.level = ?", level)
          .order("RANDOM()")
          .limit(1)
          .first,
          PlayerProblemAggregate
        )

      else
        priority = PlayerProblemAggregate.joins(:problem)
          .where(player: player, retired: false)
          .where("problems.level = ?", level)
          .where.not(updated_at: updated_at)
          .minimum(:priority)

        player_problem_aggregate = T.let(
          PlayerProblemAggregate.joins(:problem)
          .where(player: player, retired: false, priority: priority)
          .where("problems.level = ?", level)
          .where.not(updated_at: updated_at)
          .order("RANDOM()")
          .limit(1)
          .first,
          PlayerProblemAggregate
        )
      end

      T.must(player_problem_aggregate.problem)
    end
  end
end
