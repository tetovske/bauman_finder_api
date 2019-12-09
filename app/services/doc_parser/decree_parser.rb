require 'yaml'
require 'pdf-reader'

# Decree parser class
module DocParser
  class DecreeParser < Service
    include Dry::Monads::Maybe::Mixin
    include Dry::Transaction

    attr_reader :doc, :config

    CONFIG_FILE = "doc_parser_config.yaml"

    step :init_parser
    step :parse_docs

    private

    def init_parser()
      Maybe(YAML.load_file("#{Rails.root}/config/#{CONFIG_FILE}")).bind do |m|
        config = m
      end.to_result()
    end 

    def parse_docs()
      "oaaaaaa"
      Failure(15)
    end

    def parse_pdf(file_path)
      PDF::Reader.new(file_path).pages.map(&:text)
    end
  end
end