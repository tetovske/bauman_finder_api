# frozen_string_literal: true

# Request handler class
module RequestHandlers
  class RequestHandler < Service
    include Dry::AutoInject(Container)[
      parser: 'doc_parser.decree_parser'
    ]

    CONFIG_FILE = "#{Rails.root}/config/doc_parser_config.yaml"
    DOC_PATH = "#{Rails.root}/app/data/decrees"

    def call
      # update_decree_data
      5
    end

    private

    def update_decree_data
      decree_parser.call
    end
  end
end
