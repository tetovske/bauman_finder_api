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
        modules_data = yield parse_modules(main_page)
        exams_data = yield parse_exams(main_page)

        Success(exams_data.merge(modules_data))
      end

      private

      SESSION_BUTTON_ID = 16
      MODULES_BUTTON_ID = 15

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
        Success(page_r)
      end

      def parse_modules(main_page)
        k = key['parser']
        sems = k['min_year'].upto(k['max_year']).map { |n| %W[#{n}-01/ #{n}-02/] }.flatten
        data = sems.take(1).map do |sem|
          main_page.links[MODULES_BUTTON_ID].click
          pg = agent.get("#{k['webvpn_sem_main']}#{sem}")
          faculties = pg.at(k['fac_list_x']).css(k['fac_list_sel'])&.take(7).drop(6).map do |fac_page|
            fac = fac_page.css('> span')&.first&.content
            departs = fac_page.css('> .eu-tree-nodeset')&.first&.css('> li')&.take(6)&.drop(5)&.map do |dep|
              depart = dep.css('> span').first.content
              groups = dep.css('> .eu-tree-nodeset')&.first&.css('> li')&.drop(1).take(20).drop(17).map do |grp|
                group = grp.css('a')&.first&.content
                grp_url = grp.css('a')&.first&.values&.first
                page = agent.get("#{k['webvpn_main']}#{grp_url}")
                puts "parsed group: #{group}"
                { group => page.css(key['stud_c']).map { |std| yield parse_module_student(std, page, group) } }
              end
              { depart => groups.inject(&:merge) }
            end
            puts "parsed faculty: #{fac}"
            { fac => departs&.inject(&:merge) }
          end
          { sem => faculties.inject(&:merge) }
        end
        modules_data = { modules: data.inject(&:merge) }
        Success(modules_data)
      end

      def parse_exams(main_page)
        k = key['parser']
        main_page.links[SESSION_BUTTON_ID].click
        sessions = k['exam_min_index'].upto(k['exam_max_index']).map { |n| { n => "/?session_id=#{n}" } }
        sessions_per_index = sessions.map do |sess|
          page = agent.get("#{k['webvpn_ex_main']}#{sess.values.first}")
          faculties_per_session = page.css(k['exam_fac_list']).take(6).drop(5).map do |faculty|
            faculty_name = faculty.css('> span > span > b').first.content
            departments_per_faculty = faculty.css('> ul > li').take(6).drop(5).map do |dep|
              dep_name = dep.css('> span > span').first.content
              groups = dep.css('> ul > li').take(20).drop(17).map do |group_li|
                group_name = group_li.css('> i > a').first.content
                grp_url = group_li.css('> i > a').first.values.last
                group_session_page = agent.get("#{k['webvpn_main']}#{grp_url}")
                subjects = group_session_page.css(k['exam_subj_list']).drop(3).map do |subj_node|
                  subj_name = subj_node.css('> div > span').first.content
                  grade_type = subj_node.css('> div:nth-child(2) > i').first.content
                  { subj_name: subj_name, grade_type: grade_type }
                end
                students_per_group = group_session_page.css(k['student_exam_list']).map do |student|
                  parse_exam_student(student, group_name, subjects)
                end
                puts "parsed data for group: #{group_name}"
                { group_name => students_per_group }
              end
              { dep_name => groups.inject(&:merge) }
            end
            puts "parseed data for faculty: #{faculty_name}"
            { faculty_name => departments_per_faculty.inject(&:merge) }
          end
          { sess.keys.first => faculties_per_session.inject(&:merge) }
        end
        exams_data = { exams: sessions_per_index.inject(&:merge) }
        Success(exams_data)
      end

      def parse_exam_student(student, group, subjects)
        k = key['parser']
        stud_id = student.css(k['exam_stud_id']).first.content
        ini = student.css(k['exam_stud_name']).first.content.to_s.scan(/[а-яА-Я-]+/)
        exam_grades = student.css(k['student_exam_subj_grades']).drop(3).map do |subj_node|
          subj_node.css('> span').first.content
        end
        subj_info = subjects.zip(exam_grades).group_by { |n| n.first[:grade_type] }
                      .map { |k, v| { k => v.map { |n| { n.first[:subj_name] => n.last } } } }
        {
            last_name: ini.first,
            first_name: ini.second,
            mid_name: ini.third,
            id_stud: stud_id,
            group: group,
            subject_data: subj_info.inject(&:merge).transform_values { |sub| sub.inject(&:merge) }
        }
      end

      def get_form_data(form_id)
        {
          key[form_id]['usr'] => Rails.application.credentials.webvpn_login!,
          key[form_id]['pass'] => Rails.application.credentials.webvpn_pass!
        }
      end

      def parse_module_student(std, page, group)
        ini = std.at(key['name']).content.to_s.scan(/[а-яА-Я-]+/)
        stud_id = std.at(key['stud_id']).content
        scores = std.css('td').drop(3).map { |p| p.css('span').first.content }
        subjects = page.css(key['parser']['subj']).drop(3).map do |subj|
          subj_name = subj.values.last
          tag = %w[КМ М СЗ ЛР НИР КП].detect { |id| subj.content.include?(id) }
          [tag ? tag : :rating_data, subj_name]
        end
        subj_info = subjects.zip(scores).map do |x|
          x.flatten!
          [x.first, { x.second => x.last.to_i }]
        end
        subj_info = subj_info.group_by(&:first).map { |k, v| { k => v.flat_map(&:last) } }
                             .inject(&:merge).transform_values { |n| n.inject(&:merge) }
        ratings_hash = {
            "Рейтинг по группе" => :group_rating,
            "Рейтинг по кафедре и специальности" => :flow_rating,
            "Сумма модулей" => :modules_sum
        }
        subj_info[:rating_data] = subj_info[:rating_data].transform_keys(&ratings_hash.method(:[]))
        return Failure(:parse_error) if [ini, stud_id, group.first, subj_info].any?(nil)

        Success(generate_record(ini, stud_id, group, subj_info))
      end

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

      def get_subj2(page)
        page.css(key['parser']['subj']).drop(3).map do |subj|
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
