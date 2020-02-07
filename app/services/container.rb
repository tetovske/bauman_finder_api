# frozen_string_literal: true

require 'yaml'
require 'pdf-reader'
require 'selenium-webdriver'
require 'nokogiri'
require 'mechanize'
require 'jwt'

# Main container with all dependencies
class Container
  extend Dry::Container::Mixin

  namespace 'parsers' do
    namespace 'doc_parser' do
      register 'decree_parser' do
        Parsers::DocParser::DecreeParser
      end
    end

    namespace 'web_parser' do
      register 'web_vpn_parser' do
        Parsers::WebParser::WebVpnParser
      end
    end

    register 'data_validator' do
      Parsers::DataValidator
    end

    register 'scraper' do
      Parsers::WebParser::WebScraping
    end
  end

  namespace 'models' do
    register 'student' do
      Student
    end

    register 'company' do
      Company
    end

    register 'group' do
      Group
    end

    register 'form_of_study' do
      FormOfStudy
    end

    register 'black_list' do
      BlackList
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

    register 'selenium' do
      Selenium::WebDriver
    end

    register 'scraping_api' do
      Mechanize
    end

    register 'jwt' do
      JWT
    end

    register 'request_handler' do
      RequestHandlers::RequestHandler
    end

    register 'jwt_manager' do
      Other::JwtDecoder
    end

    register 'token_generator' do
      Other::TokenGenerator
    end
  end
end
