
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
        self.driver.navigate.to(path)
      end

      def await
        wait = Selenium::WebDriver::Wait.new(:timeout => 10)
        wait.until { !yield }
      end

      def teardown_parser
        self.driver.quit!
      end
    end
  end
end