module Processing
  class Finder < Service
    include Processing::Search
    include Dry::Monads[:result, :do, :maybe, :try]
    include Dry::AutoInject(Container)[
      'services.key_keeper',
      'services.strategic_finder'
    ]

    def call(search_function, search_args = {})
      yield setup
      data = yield match_search_args(search_args)
      find_by_strategy(search_function, data)
    end

    private

    attr_reader :keys, :strategies

    def setup
      @keys = yield key_keeper.call
      @startegies = {
        first_name: Processing::Search::FindByValue,
        last_name: Processing::Search::FindByValue,
        mid_name: Processing::Search::FindByValue,
        exam_scores: Processing::Search::FindByValue,
        group: Processing::Search::FindByGroup
      }

      Success()
    end

    def find_by_strategy(search_function, search_args)
      search_args.each do |key, value|
        strategic_finder.call(startegies[key], search_function, search_args)
      end

      Success()
    end

    def match_search_args(srch)
      mth_match = keys['search_args_matching']
      srch = srch.map { |k, v| [mth_match[k.to_s], v] if mth_match.key?(k.to_s) }.compact.to_h

      Success(srch)
    end
  end
end