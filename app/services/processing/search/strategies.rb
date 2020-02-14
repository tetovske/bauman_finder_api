module Processing
  module Search
    class Strategy
      attr_reader :search_methods

      def search
        raise NotImplementedError, "The class #{self.class} has not implemented #{__method__.to_s}"
      end
    end

    class FindByValue < Strategy
      def initialize
        @search_methods = {
          find: ->(args) { Student.where(args.first.first => args.first.last) },
          find_except: ->(args) { Student.where.not(args.first.first => args.first.last) }
        }
      end

      def search(search_func, args)
        search_methods[search_func].call(args)
      end
    end

    class FindByGroup < Strategy
      def initialize
        @search_methods = {
          find: ->(args) { Student.joins(:group).where(groups: { name: args }) },
          find_except: ->() { Student.joins(:group).where.not(groups: { name: args }) }
        }
      end

      def search(search_func, args)
        search_methods[search_func].call(args)
      end
    end
  end
end