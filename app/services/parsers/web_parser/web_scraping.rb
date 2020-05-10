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
        main_page = yield login2(agn)
        yield parse_exams(main_page)
        #data = yield test
        #data = yield parse_modules(main_page)

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
        return Success(page_r)
      end

      def test
        k = key['module']
        sems = 2018.upto(k['max_year']).map { |n| %W[#{n}-01/ #{n}-02/] }.flatten
        sems.map do |sem|
          pg = self.agent.get("#{k['webvpn_sem_main']}#{sem}")
          pg.css(k['fac_list_sel']).each do |fuc|
            puts fuc.css('> span').first.content
          end
        end
      end

      def parse_modules(main_page)
        k = key['module']
        sems = 2018.upto(k['max_year']).map { |n| %W[#{n}-01/ #{n}-02/] }.flatten
        data = sems.map do |sem|
          main_page.links[15].click
          pg = self.agent.get("#{k['webvpn_sem_main']}#{sem}")
          faculties = pg.at(k['fac_list_x']).css(k['fac_list_sel']).map do |fac_page|
            fac = fac_page.css('> span').first.content
            departs = fac_page&.css('> .eu-tree-nodeset')&.first&.css('> li')&.map do |dep|
              depart = dep.css('> span').first.content
              groups = dep.css('> .eu-tree-nodeset').first.css('> li').drop(1).map do |grp|
                group = grp.css('a').first.content
                grp_url = grp.css('a').first.values.first
                page = self.agent.get("#{k['webvpn_main']}#{grp_url}")
                { group => page.css(key['stud_c']).map { |std| yield parse_std2(std, page, group) } }
              end
              { depart => groups }
            end
            { fac => departs }
          end
          { sem => faculties }
        end
        Success(data)
      end

      def parse_exams(main_page)
        k = key['module']
        main_page.links[16].click
        sessions = 27.upto(k['exam_max_index']).map { |n| "/?session_id=#{n}" }
        sessions.map do |sess|
          page = self.agent.get("#{k['webvpn_ex_main']}#{sess}")
          page.css(k['exam_fac_list']).map do |faculty|
            faculty_name = faculty.css('> span > span > b').first.content
            faculty.css('> ul > li').map do |dep|
              dep_name = dep.css('> span > span').first.content
              puts dep.css('> span > span').first.content
            end
          end
        end
        Success()
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

      def parse_std2(std, page, group)
        ini = std.at(key['name']).content.to_s.scan(/[а-яА-Я-]+/)
        stud_id = std.at(key['stud_id']).content
        scores = std.css('td').drop(3).map { |p| p.css('span').first.content }
        subjects = page.css(key['module']['subj']).drop(3).map do |subj|
          subj_name = subj.values.last
          tag = %w[КМ М СЗ ЛР НИР КП].detect { |id| subj.content.include?(id) }
          [tag, subj_name]
        end
        subj_info = subjects.zip(scores).map do |x|
          x.flatten!
          [x.first, { x.second => x.last.to_i }]
        end
        subj_info = subj_info.group_by(&:first).map { |k, v| { k => v.flat_map(&:last) } }
        return Failure(:parse_error) if [ini, stud_id, group.first, subj_info].any?(nil)

        Success(generate_record(ini, stud_id, group, subj_info))
      end

      # def parse_std(std, group, page)
      #   ini = std.at(key['name']).content.to_s.scan(/[а-яА-Я-]+/)
      #   stud_id = std.at(key['stud_id']).content
      #   scores = (4..33).map do |id|
      #     rgx = "td[#{id}]/span"
      #     id < 12 ? std.at("#{rgx}/span").content : std.at(rgx.to_s).content
      #   end
      #   subj_info = get_subj(page, key['subj_x']).zip(scores).to_h
      #   return Failure(:parse_error) if [ini, stud_id, group.first, subj_info].any?(nil)
      #
      #   Success(generate_record(ini, stud_id, group.first, subj_info))
      # end

      def generate_record(name, id, group, subj_info)
        {
          last_name: name.first,
          first_name: name.second,
          mid_name: name.third,
          id_stud: id,
          group: group,
          subject_data: subj_info
        }
      end

      # def get_subj(page, xpath)
      #   (4..33).map do |num|
      #     path = "#{xpath}[#{num}]"
      #     name = page.at(path)
      #     postfix = %w[КМ М СЗ ЛР НИР КП].detect { |id| name.content.include?(id) }
      #     "#{name['title']} #{postfix}"
      #   end
      # end

      def get_subj2(page)
        page.css(key['module']['subj']).drop(3).map do |subj|
          subj_name = subj.values.last
          tag = %w[КМ М СЗ ЛР НИР КП].detect { |id| subj.content.include?(id) }
          [tag, subj_name]
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