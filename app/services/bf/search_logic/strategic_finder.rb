module Bf
  module SearchLogic
    class StrategicFinder < Service
      include Dry::Monads[:result, :maybe]

      attr_accessor :strategy
      attr_reader :strategies_list

      def call(inter_search, strategy_name, search_func, arg)
        yield setup(strategy_name)
        res = yield find(inter_search, search_func, arg)

        Success(res)
      end

      private

      def setup(str_name)
        @strategies_list = {
          name: FindByValue,
          last_name: FindByValue,
          mid_name: FindByValue,
          exam_scores: FindByValue,
          group: FindByGroup
        }
        self.strategy = strategies_list[str_name].new

        Success()
      end

      def find(inter_search, search_func, arg)
        Success(strategy.search(inter_search, search_func, arg))
      end
    end

    class Strategy
      include Dry::Monads[:do]

      attr_reader :search_methods, :keys

      def initialize
        @keys = yield KeyKeeper.call
      end

      def search
        raise NotImplementedError, "The class #{self.class} has not implemented #{__method__.to_s}"
      end
    end

    class FindByValue < Strategy
      def initialize 
        super
        @search_methods = {
          find: ->(data, args) { data.where(args) },
          find_except: ->(data, args) { data.where.not(args.first.first => args.first.last) }
        }
      end

      def search(data, search_func, args)
        args = args.transform_keys { |key| keys['search_args_matching'][key.to_s] }
        search_methods[search_func.to_sym].call(data, args)
      end
    end

    class FindByGroup < Strategy
      def initialize
        super
        @search_methods = {
          find: ->(args) { Student.joins(:group).where(groups: { name: args }) },
          find_except: ->() { Student.joins(:group).where.not(groups: { name: args }) }
        }
      end

      def search(search_func, args)
        search_methods[search_func].call(args.values.first)
      end
    end
  end
end