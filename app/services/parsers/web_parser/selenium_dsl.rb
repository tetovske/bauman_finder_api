# frozen_string_literal: true

# Parsers
module Parsers
  # Web parser scripts
  module WebParser
    # Some funcs for selenium
    module SeleniumDsl
      PARSER_CONFIG = "#{Rails.root}/config/web_parser_config.yaml"

      attr_accessor :driver, :config, :links

      def setup
        self.driver = selenium.for :firefox
        cnf = self.config = yaml.load_file(PARSER_CONFIG)['links']
        self.links = cnf.keys.map { |k| { k.to_sym => cnf[k] } }.first
        if driver.nil? && links.nil?
          Failure(:parser_setup_failed)
        else
          Success(links)
        end
      end

      def go(path)
        driver.navigate.to(path)
      end

      def await_presence(event)
        wait = Selenium::WebDriver::Wait.new(timeout: 10)
        wait.until { presence(event).call }
      end

      def presence(element)
        -> { !driver.find_elements(element).empty? }
      end

      def fill_field(elem, content)
        driver.find_elements(elem).first.send_keys content
      end

      def click_on(elem)
        driver.find_elements(elem).first.click
      end

      def teardown_parser
        driver.quit
        Success()
      end
    end
  end
end
