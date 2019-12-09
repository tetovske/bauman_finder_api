# Request handler class
module RequestHandlers
  class RequestHandler < Service
    include DocParser
    include Dry::Monads::Maybe::Mixin
    include Dry::Monads::Result::Mixin
  
    def call(params:, value:)
      DecreeParser.call().value_or(false) do |err| 
        handle_issue(err) do
          puts "hello"
        end
      end
    end

    private

    def update_decree_data
      
    end
  end
end