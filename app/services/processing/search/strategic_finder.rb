module Processing
  module Search
    class StrategicFinder < Service
      include Dry::Monads[:result, :maybe]

      attr_accessor :startegy

      def call(strategy, search_func, args)
        Maybe(startegy).bind do
          self.startegy = startegy.new
          Success()
        end.or(Failure(:undefined_startegy))
        Succes(strategy.search(search_func, args))
      end
    end
  end
end