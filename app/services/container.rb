# frozen_string_literal: true

require 'yaml'
require 'pdf-reader'

# Main container with all dependencies
class Container
  extend Dry::Container::Mixin

  namespace 'doc_parser' do
    register 'decree_parser' do
      DocParser::DecreeParser
    end
  end

  namespace 'models' do
    register 'student' do
      Student
    end
  end

  namespace 'services' do
    register 'key_keeper' do
      KeyKeeper 
    end

    register 'yaml_parser' do 
      YAML
    end

    register 'pdf_reader' do
      PDF::Reader
    end
  end
end