# frozen_string_literal: true

# Parsers
module Parsers
  # Web parser scripts
  module WebParser
    # Mechanize parser
    class WebScraping < Service
      include Dry::AutoInject(Container)[
        'services.mechanize'
      ]

      MAIN_LINK = 'https://webvpn.bmstu.ru/+CSCO+1h75676763663A2F2F72682E6F7A6667682E6568++/modules/progress3/'
      GROUPS = {
        :iu6_31 => 'group/8e243850-3d75-11e8-9f9b-005056960017/',
        :iu6_32 => 'group/8e282802-3d75-11e8-8869-005056960017/',
        :iu6_33 => 'group/8e2955e2-3d75-11e8-9b85-005056960017/',
        :iu6_34 => 'group/8e2c2f2e-3d75-11e8-a507-005056960017/',
        :iu6_35 => 'group/8e2d07c8-3d75-11e8-94be-005056960017/'
      }

      def call
        yield setup
        main_page = yield login
        data = yield parse_group(GROUPS)
        Success(data)
      end

      private

      attr_accessor :agent

      def setup
        self.agent = mechanize.new(user_agent_alias: 'Mac Safari 4')
        return Success(agent) unless agent.nil?
        Failure(:parser_setup_failed)
      end

      def login 
        agn = self.agent
        lg1_page = agn.get 'https://webvpn.bmstu.ru/+CSCOE+/logon.html'
        form_filler(
          lg1_page.forms.first,
          { 'username' => 'dtd18u229', 'password_input' => 'rzdpez6x' }
        )
        page = agn.get 'https://webvpn.bmstu.ru/+CSCO+1075676763663A2F2F636265676E79332E72682E6F7A6667682E6568++/portal3/login1?back=https://eu.bmstu.ru/'
        lg2_page = agn.get(page.at('/html/body/div[1]/div/a[1]')['href'])
        page_r = form_filler(
          lg2_page.forms.first,
          { 'username' => 'dtd18u229', 'password' => 'rzdpez6x' }
        ).value_or("")
        page_f = page_r.links[14].click
        return Success(page_f) if page_f.links.last.text.include?('семестр')
        Failure(:error_while_login)
      end

      def parse_group(groups)
        agn = self.agent
        data = groups.map do |group|
          page = agn.get "#{MAIN_LINK}#{group}"
          subj = (4..33).map do |num|
            page.at("/html/body/div[1]/div[7]/div/div[3]/div/div[2]/div/table/thead/tr/th[#{num}]")['title']
          end
          page.css('table.standart_table:nth-child(1) > tbody:nth-child(3) > tr').map do |stud|
            name = stud.at('td[2]/a/nobr/span[3]').content.to_s.scan(/[а-яА-Я-]+/)
            stud_id = stud.at('td[3]').content
            scores = (4..33).map do |id|
              if id < 12
                stud.at("td[#{id}]/span/span").content
              else
                stud.at("td[#{id}]/span").content
              end
            end
            [name, stud_id, scores]
          end
        end
        Success(data)
      end

      def form_filler(form, data)
        data.each { |key ,value| form.field_with(id: key).value = value }
        res_page = form.submit
        return Success(res_page) unless res_page.nil?
        Failure(:error_while_form_sub)
      end
    end
  end
end