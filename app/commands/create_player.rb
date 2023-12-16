# # typed: strict

module Commands
  class CreatePlayer < Commands::Base
    extend T::Sig

    STARTING_LEVEL = T.let(1, Integer)

    sig do
      params(input: ActionController::Parameters)
        .returns(Player)
    end
    def call(input:)
      Player.create(user_id: input[:user_id], name: input[:name], level: STARTING_LEVEL)
    end
  end
end
