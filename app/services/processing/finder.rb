

module Processing
  class Finder < Service
    include Dry::Monads[:result, :do, :maybe, :try]
    include Dry::AutoInject(Container)[
      'services.key_keeper'
    ]

    def call(search_function, search_args = {})
      match_search_methods()
      yield select_method(search_function, search_args)
    end

    private

    def select_method(search_function, search_args)
      case search_function
      when :find
        ->()
      when :find_first
        Student.find_by()
      when :find_except
        find_except(search_args)
      when :find_except_first
        find_except_first(search_args)
      else
        Failure(:unknown_search_function)
      end
    end

    def match_search_methods(srch)
      args = key_keeper.call['search_method_matching']
                .transform_keys(&:to_sym).transform_values { '*' }
      srch.transform_keys(&:to_sym)
    end
  end
end