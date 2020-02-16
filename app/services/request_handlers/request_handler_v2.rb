# frozen_string_literal: true

# Request handler class
module RequestHandlers
  # Request handler class
  class RequestHandlerV2 < Service
    include Dry::Monads[:result, :do, :maybe, :try]
    include Dry::AutoInject(Container)[
      'services.key_keeper',
      bf: 'services.finder'
    ]

    def call(params = {})
      handle(params).bind do |data|
        Success(
          {
            status: :success,
            data: data
          }
        )
      end.or do |err|
        Success(
          {
            status: :failed,
            cause: err,
            data: []
          }
        )
      end
    end

    private

    attr_accessor :keys

    def handle(params)
      yield setup
      yield validate_search_args(params)
      data = yield bf.call(:find, params)

      Success(data)
    end

    def setup
      self.keys = yield key_keeper.call

      Success()
    end

    def validate_search_args(params)
      return Failure(:invalid_args) unless params and params&.keys.all? { |k| keys['search_methods_args'].include?(k.to_s) }

      Success()
    end
  end
end
