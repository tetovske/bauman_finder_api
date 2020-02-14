module Processing
  class Finder < Service
    include Dry::Monads[:result, :do, :maybe, :try]
    include Dry::AutoInject(Container)[
      'services.key_keeper'
    ]

    def call(search_function, search_args = {})
      data = yield match_search_args(search_args)
      yield select_method(search_function, data)
    end

    private

    def select_method(search_function, search_args)
      case search_function
      when :find
        Success(Student.where(search_args))
      when :find_first
        Success(Student.where(search_args).first)
      when :find_except
        Success(Student.where.not(search_args))
      when :find_except_first
        Success(Student.where.not(search_args).first)
      else
        Failure(:unknown_search_function)
      end
    end

    def match_search_args(srch)
      mth_match = key_keeper.call.value_or({})['search_method_matching']
      srch = srch.map { |k, v| [mth_match[k.to_s], v] if mth_match.key?(k.to_s) }.compact.to_h

      Success(srch)
    end
  end
end