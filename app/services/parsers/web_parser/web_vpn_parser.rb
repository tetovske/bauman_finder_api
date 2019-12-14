# frozen_string_literal: true

require 'selenium-webdriver'

# Parsers
module Parsers
  # Web parser scripts
  module WebParser
    # Selenium parser
    class WebVpnParser < Service
      include SeleniumDsl
      include Dry::AutoInject(Container)[
        'services.selenium',
        yaml: 'services.yaml_parser'
      ]

      def call
        yield setup
        yield login
      end

      private

      def login
        go links[:login1]
        await { driver.find_elements(:id, 'csco_logon_form').empty? }
        
      end
    end
  end
end
