# frozen_string_literal: true

require 'yaml'
require 'pdf-reader'

# Contains logic for document parsing
class DocParser
  include Interactor

  before :init_parser
  attr_reader :docs, :config

  CONFIG_FILE_PATH = "#{Rails.root}/config/doc_parser_config.yaml"

  private

  def init_parser
    self.docs = parse_pdf('')
    self.config = YAML.load_file(CONFIG_FILE_PATH)
  end

  def parse_pdf(file_path)
    PDF::Reader.new(file_path).pages.map(&:text)
  end
end
