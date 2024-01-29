# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `DeleteRequestJob`.
# Please instead update this file by running `bin/tapioca dsl DeleteRequestJob`.

class DeleteRequestJob
  class << self
    sig { params(request_id: ::Integer).returns(T.any(DeleteRequestJob, FalseClass)) }
    def perform_later(request_id:); end

    sig { params(request_id: ::Integer).void }
    def perform_now(request_id:); end
  end
end
