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
        yield parse_pages
        yield teardown_parser

        Success()
      end

      private

      def login
        go links[:login1]
        await_presence id: 'csco_logon_form'
        fill_field({ id: 'username' }, 'dtd18u229')
        fill_field({ id: 'password_input' }, 'rzdpez6x')
        click_on xpath: '/html/body/div[1]/div/div/div[2]/div/div[2]/table/tbody/tr[2]/td/div/table/tbody/tr/td/div/form/table/tbody/tr[2]/td/div/table/tbody/tr[4]/td/input'
        await_presence id: 'history'
        go "javascript: parent.doURL('75676763663A2F2F72682E6F7A6667682E6568',[{ 'l' : '4829322D03D1606FB09AE9AF59A271D3', 'n' : 1}],'get',false,'no', false)"
        await_presence id: 'CSCO_tbdiv'
        click_on xpath: '/html/body/div[1]/div/a[1]'
        await_presence id: 'cas'
        fill_field({ id: 'username' }, 'dtd18u229')
        fill_field({ id: 'password' }, 'rzdpez6x')
        click_on class: 'btn-submit'
        await_presence xpath: '/html/body/div[1]/div[7]/div/ul/li[1]/a'
        click_on xpath: '/html/body/div[1]/div[7]/div/ul/li[1]/a'
        Success(:done)
      end

      def parse_pages
        go 'https://webvpn.bmstu.ru/+CSCO+1h75676763663A2F2F72682E6F7A6667682E6568++/modules/progress3/group/8e2955e2-3d75-11e8-9b85-005056960017/'
      end
    end
  end
end
