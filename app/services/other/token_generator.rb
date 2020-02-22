# frozen_string_literal: true

# All service objects
module Other
  # Class for encode/decode jwt key
  class TokenGenerator < Service
    include Dry::Monads[:result, :do]

    def call(size)
      result = yield generate_by_size(size)

      Success(result)
    end

    private

    def generate_by_size(size)
      token = 1.upto(size).map { (('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a)[rand(62)] }.join
      Success(token)
    end
  end
end
