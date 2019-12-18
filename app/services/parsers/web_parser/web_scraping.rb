# frozen_string_literal: true

# Parsers
module Parsers
  # Web parser scripts
  module WebParser
    # Mechanize parser
    class WebScraping < Service
      include Dry::AutoInject(Container)[
        scraping: 'services.scraping_api',
        key_keeper: 'services.key_keeper'
      ]

      def call
        yield setup
        agn = agent
        yield login1(agn)
        yield login2(agn)
        data = yield parse_group(agn)

        Success(data)
      end

      private

      attr_accessor :agent, :key

      def setup
        self.agent = scraping.new(user_agent_alias: 'Mac Safari 4')
        keys = yield key_keeper.call
        self.key = keys['web']
        return Success(agent) unless agent.nil?

        Failure(:parser_setup_failed)
      end

      def login1(agn)
        lg1 = agn.get key['login1_u']
        yield form_filler(
          lg1.forms.first,
          get_form_data('form1')
        )
        Success()
      end

      def login2(agn)
        lg1 = agn.get key['login1_1_u']
        lg2 = agn.get(lg1.at(key['login2_x'])['href'])
        page_r = yield form_filler(
          lg2.forms.first,
          get_form_data('form2')
        )
        page_f = page_r.links[14].click
        return Success(page_f) if page_f.links.last.text.include?('семестр')

        Failure(:error_while_login)
      end

      def get_form_data(form_id)
        {
          key[form_id]['usr'] => Rails.application.credentials.webvpn_login!,
          key[form_id]['pass'] => Rails.application.credentials.webvpn_pass!
        }
      end

      def parse_group(agn)
        data = key['groups'].map do |grp|
          page = agn.get "#{key['home_u']}#{grp}"
          page.css(key['stud_c']).map { |std| yield parse_std(std, grp, page) }
        end
        Success(data.flatten)
      end

      def parse_std(std, group, page)
        ini = std.at(key['name']).content.to_s.scan(/[а-яА-Я-]+/)
        stud_id = std.at(key['stud_id']).content
        scores = (4..33).map do |id|
          rgx = "td[#{id}]/span"
          id < 12 ? std.at("#{rgx}/span").content : std.at(rgx.to_s).content
        end
        subj_info = get_subj(page, key['subj_x']).zip(scores).to_h
        return Failure(:parse_error) if [ini, stud_id, group.first, subj_info].any?(nil)

        Success(generate_record(ini, stud_id, group.first, subj_info))
      end

      def generate_record(name, id, group, subj_info)
        {
          first_name: name.first,
          last_name: name.second,
          mid_name: name.third,
          stud_id: id,
          group: group,
          subject_data: subj_info
        }
      end

      def get_subj(page, xpath)
        (4..33).map do |num|
          path = "#{xpath}[#{num}]"
          name = page.at(path)
          postfix = %w[КМ М СЗ ЛР].detect { |id| name.content.include?(id) }
          "#{name['title']} #{postfix}"
        end
      end

      def form_filler(form, data)
        data.each { |k, v| form.field_with(id: k).value = v }
        res_page = form.submit
        return Success(res_page) unless res_page.nil?

        Failure(:error_while_form_sub)
      end
    end
  end
end
