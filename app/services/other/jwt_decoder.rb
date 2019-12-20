# frozen_string_literal: true

# All service objects
module Other
  # Class for encode/decode jwt key
  class JwtDecoder < Service
    include Dry::Monads[:result, :do]
    include Dry::AutoInject(Container)[
      'services.jwt'
    ]

    SECRET_KEY = Rails.application.secrets.secret_key_base
    ALGORITHM = 'HS256'

    def call
      self
    end

    def encode_key(data)
      return Failure(:arg_isnt_hash) unless data.is_a?(Hash)

      data = jwt.encode data, SECRET_KEY, ALGORITHM
      return Success(data) unless data.nil?

      Failure(:failed_to_create_key)
    end

    def decode_key(token)
      Try { jwt.decode token, SECRET_KEY, ALGORITHM }
        .bind { |data| Success(data.first) }
        .or(Failure(:invalid_token))
    end
  end
end
