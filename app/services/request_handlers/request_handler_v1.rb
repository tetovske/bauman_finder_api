# frozen_string_literal: true

module RequestHandlers
  class RequestHandlerV1 < Service
    include Dry::Monads[:result, :do, :maybe, :try]
    include Dry::AutoInject(Container)[
      'services.key_keeper'
    ]

    def call(params = [])
      params = yield extract_search_params(params)
      yield setup
      yield valid_params?(params)

      Success(:succeeded)
    end

    private

    attr_accessor :keys

    def setup
      self.keys = yield key_keeper.call

      Success()
    end

    # validate income params from user
    def valid_params?(params)
      yield validate_search_function(params)
      yield validate_search_args(params)

      Success(:validatation_succeeded)
    end

    def validate_search_function(params)
      return Failure(:missing_search_function) unless params.keys.include?(keys['search_method_key_name'])

      sup_meth = keys['search_methods']
      return Failure(:invalid_search_method) unless sup_meth.include?(params[keys['search_method_key_name'].to_sym])

      Success()
    end

    def validate_search_args(params)
      return Failure(:missing_search_args) if params.reject { |k| %w[search_meth].include?(k) }.empty?

      sup_args = keys['search_methods_args'].map(&:to_sym)
      return Failure(:invalid_search_args) unless sup_args.all? { |a| sup_args.include?(a) }

      Success()
    end

    def extract_search_params(params)
      params = params.reject { |k| %w[format controller action].include?(k) }

      Success(params)
    end
  end
end
