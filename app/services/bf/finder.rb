# frozen_string_literal: true

module Bf
  class Finder < Service
    include Dry::Monads[:result, :do, :maybe, :try]
    include Dry::AutoInject(Container)[
      'services.key_keeper',
      sf: 'services.strategic_finder'
    ]

    def call(search_function, search_args = {})
      yield setup
      data = yield find_by_strategy(search_function, search_args)

      Success(data)
    end

    private

    attr_reader :keys

    def setup
      @keys = yield key_keeper.call

      Success()
    end

    def find_by_strategy(search_function, search_args)
      inter_search = Student.all
      search_args.each do |key, value|
        inter_search = yield sf.call(inter_search, key.to_sym, search_function.to_sym, key => value)
      end

      Success(inter_search)
    end
  end
end
