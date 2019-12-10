# frozen_string_literal: true

require 'yaml'
require 'pdf-reader'

# Decree parser module
module DocParser
  # Service object for decree pasring
  class DecreeParser < Service
    step :init_parser
    step :parse_docs

    private

    def init_parser(_input, config_path:)
      Try { YAML.load_file(config_path)['docs'] }
        .bind { |file| Success(file) }
        .or(Failure(:init_parser))
    end

    def convert_doc(docs_config, doc_path:)
      
    end

    def parse_docs(docs_config, doc_path:)
      students = docs_config.map do |doc|
        path = "#{doc_path}/#{doc['year']}/#{doc['file_name']}"
        parse_pdf(path).bind do |parsed|
          find_by_regex(parsed.value!, doc['regex'])
        end.value_or([])
      end

    end

    def find_by_regex(data, regex)
      Maybe(regex.map { |reg| data.scan(Regexp.new(reg)) }
        .reduce { |x, y| x + y }).to_result
    end

    def parse_pdf(file_path)
      Try { PDF::Reader.new(file_path).pages.map(&:text).join }
        .bind { |data| Success(data) }
        .or(Failure(:file_reading))
    end
  end
end
