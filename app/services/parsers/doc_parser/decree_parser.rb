# frozen_string_literal: true

# Parsers module
module Parsers
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
        decrees_path = yield key_keeper.call('decrees_docs_path')
        config = yield init_parser("#{Rails.root}#{config_path}")
        stud_resords = yield parse_doc(config, "#{Rails.root}#{decrees_path}")
        Success(stud_resords)
      end

      def init_parser(config_path)
        Try { yaml.load_file(config_path)['docs'] }
          .bind { |file| Success(file) }
          .or(Failure(:init_parser_fail))
      end

      def parse_doc(docs_config, doc_path)
        data = docs_config.map do |cnf|
          txt = yield parse_pdf("#{doc_path}/#{cnf['year']}/#{cnf['file_name']}")
          students = yield find_by_regex(txt, cnf['regexes'])
          students.map do |stud|
            stud[:year] = cnf['year']
            stud[:form_of_study] = cnf['form_of_study']
            stud
          end
        end
        Success(data.reduce { |a, b| a + b })
      end

      def find_by_regex(data, regex)
        students = regex.map do |reg|
          data.scan(Regexp.new(reg['regex'])).map do |el|
            model = reg['model'].map(&:to_sym)
            return Failure(:regex_error) unless el.size == model.size

            model.zip(el).to_h
          end
        end
        Success(students.reduce { |a, b| a + b })
      end

      def parse_pdf(file_path)
        Try { pdf_parser.new(file_path).pages.map(&:text).join }
          .bind { |data| Success(data) }
          .or(Failure(:file_reading))
      end
    end
  end
end