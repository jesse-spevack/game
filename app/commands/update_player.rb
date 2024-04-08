# typed: strict

module Commands
  class UpdatePlayer < Commands::Base
    class Result < T::Struct
      const :player, Player
      const :success, T::Boolean
      const :error, T.nilable(StandardError)
    end

    extend T::Sig
    sig { params(player: Player, input: ActionController::Parameters).returns(Result) }
    def call(player:, input:)
      level_param = T.let(input[:level], String)
      new_level = level_param.to_i

      changing_level_down = T.let(new_level < player.level, T::Boolean)
      changing_level_up = T.let(new_level > player.level, T::Boolean)

      if changing_level_down
        problems = Problem.where(level: (new_level..player.level))

        # If a player level decreases we need to reset progress by clearing out the aggregates
        begin
          ActiveRecord::Base.transaction do
            player.update!(input)
            PlayerProblemAggregate.where(player: player, problem: problems).destroy_all
          end
        rescue => e
          Result.new(
            player: player,
            success: false,
            error: e
          )
        end
      elsif changing_level_up
        problems = Problem.where(level: (player.level..new_level))

        # If a player level increases we need to initialize progress by creating the aggregates
        begin
          ActiveRecord::Base.transaction do
            player.update!(input)
            Rails.logger.info("Update ok!!!!!")
            Commands::CreatePlayerProblemAggregatesForLevel.call(player: player, level: player.level)
            Rails.logger.info("aggregates created")
          end
        rescue => e
          Result.new(
            player: player,
            success: false,
            error: e
          )
        end
      else
        begin
          # If there is no level change, just update the player
          Rails.logger.info("About to update.")
          player.update!(input)
          Rails.logger.info("updated.")
        rescue => e
          Result.new(
            player: player,
            success: false,
            error: e
          )
        end
      end

      Result.new(
        player: player,
        success: true
      )
    end
  end
end
