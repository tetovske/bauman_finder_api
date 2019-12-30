# frozen_string_literal: true

# Parsers module
module Parsers
  # Main class for manage all parsers
  class ParserManager < Service
    include Dry::AutoInject(Container)[
      'parsers.doc_parser.decree_parser',
      'parsers.scraper',
      'parsers.data_validator'
    ]

    def call
      self
    end

    def update_decree_data
      decree_data = yield decree_parser.call
      data_validator.call(decree_data, :decree_data)
    end

    def update_webvpn_data
      data = yield scraper.call
      data_validator.call(data, :web_data)
    end
  end
end
