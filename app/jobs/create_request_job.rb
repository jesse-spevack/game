# typed: strict

class CreateRequestJob < ApplicationJob
  extend T::Sig

  queue_as :default

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
    ).void
  end
  def perform(user_id:, controller:, action:, query_parameters:, request_parameters:, method:, uuid:, referer:)
    Rails.logger.info("CreateRequestJob: #{user_id}, #{controller}, #{action}, #{query_parameters}, #{request_parameters}, #{method}, #{uuid}, #{referer}")
    Commands::CreateRequest.call(
      user_id: user_id,
      controller: controller,
      action: action,
      query_parameters: query_parameters,
      request_parameters: request_parameters,
      method: method,
      uuid: uuid,
      referer: referer
    )
  end
end
