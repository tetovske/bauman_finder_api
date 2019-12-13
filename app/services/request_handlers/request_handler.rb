# frozen_string_literal: true

# Request handler class
module RequestHandlers
  class RequestHandler < Service
    include Dry::AutoInject(Container)[
      parser: 'doc_parser.decree_parser'
    ]

    def call
      
    end

    private

    def update_decree_data
      decree_parser.call
    end
  end
end
