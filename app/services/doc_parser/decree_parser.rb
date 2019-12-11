# frozen_string_literal: true

# Decree parser module
module DocParser
  # Service object for decree pasring
  class DecreeParser < Service
    include Dry::AutoInject(Container)[
      key_keeper: 'services.key_keeper',
      pdf_parser: 'services.pdf_reader',
      yaml: 'services.yaml_parser'
    ]

    def call
      config_path = yield key_keeper.call('doc_parser_config')
      # TODO: СДЕЛАТЬ БЛЯТЬ УЖЕ ЭТОТ ЕБУЧИЙ ПАРСЕР НАХУЙ
    end

    private

    def init_parser(config_path:)
      Try { yaml.load_file(config_path)['docs'] }
        .bind { |file| Success(file) }
        .or(Failure(:init_parser))
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
