# # typed: strict

module Commands
  class CreateRequest < Commands::Base
    extend T::Sig

    sig do
      params(
        user_id: Integer,
        controller: String,
        action: String,
        query_parameters: T.nilable(String),
        request_parameters: T.nilable(String),
        method: String,
        uuid: String,
        referer: T.nilable(String)
      ).returns(Request)
    end
    def call(user_id:, controller:, action:, query_parameters:, request_parameters:, method:, uuid:, referer:)
      parsed_query_params = query_parameters.nil? ? nil : JSON.parse(query_parameters)
      parsed_request_params = request_parameters.nil? ? nil : JSON.parse(request_parameters)
      request = T.let(Request.create(
        user_id: user_id,
        controller: controller,
        action: action,
        query_parameters: parsed_query_params,
        request_parameters: parsed_request_params,
        method: method,
        uuid: uuid,
        referer: referer
      ), Request)

      DeleteRequestJob.set(wait: 1.month).perform_later(request: request.id)
      request
    end
  end
end
