

module RequestHandlers
  class RequestHandlerV1 < Service
    include Dry::Monads[:result, :do, :maybe, :try]
    include Dry::AutoInject(Container)[
      keys: 'services.key_keeper'
    ]

    def call(params = [])
      yield valid_params?(params)
    end

    private

    def valid_params?(params = [])
      sup_meth = keys['search_methods'].map(&:to_sym)
      sup_args = keys['search_methods_args'].map(&:to_sym)
      return Failure(:invalid_search_method) unless sup_meth.include?(params[:search_meth].to_sym)
      return Failure(:invalid_search_method_args) unless sup_args.include?(params[:search_meth].to_sym)
    
      Success()
    end
  end
end