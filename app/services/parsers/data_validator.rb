# frozen_string_literal: true

# Parsers module
module Parsers
  # Fill tables with data coming from parsers
  class DataValidator < Service
    include Dry::AutoInject(Container)[
      'models.student',
      'models.company',
      'models.group',
      study_f: 'models.form_of_study'
    ]

    def call(data, data_type)
      case data_type
      when :decree_data
        update_groups_and_companies(data)
        update_by_decrees(data)
      when :web_data
        update_webvpn_data(data)
      else
        Failure(:unsupported_data_type)
      end
    end

    private

    def update_by_decrees(data)
      data.each do |stud|
        record = student.new(
          first_name: stud[:first_name],
          last_name: stud[:last_name],
          mid_name: stud[:mid_name],
          id_stud: stud[:id_stud],
          id_abitur: stud[:id_abitur],
          exam_scores: stud[:exam_scores].to_i,
          form_of_study: study_f.find_by(title: stud[:form_of_study]),
          group_adm: group.find_by(name: stud[:group_adm])
        )
        if record.valid?
          record.save
        else
          upd = student.find_by(id_stud: stud[:id_stud])
          upd&.update(
            first_name: stud[:first_name],
            last_name: stud[:last_name],
            mid_name: stud[:mid_name],
            exam_scores: stud[:exam_scores].to_i,
            form_of_study: study_f.find_by(title: stud[:form_of_study]),
            group_adm: group.find_by(name: stud[:group_adm])
          )
        end
      end
    end

    def update_groups_and_companies(data)
      data.map do |stud|
        company.new(company_name: stud[:company]).save
        group.new(name: stud[:group]).save
      end
    end

    def update_webvpn_data(data)
      data.each do |rec|
        record = student.new(
          first_name: rec[:first_name],
          last_name: rec[:last_name],
          mid_name: rec[:mid_name],
          id_stud: rec[:id_stud],
          group: detect_group(rec[:group]),
          subject_data: rec[:subject_data].to_json
        )
        if record.valid?
          record.save
        else
          stud = student.find_by(id_stud: rec[:id_stud])
          unless stud.nil?
            student.update(
              stud.id,
              subject_data: rec[:subject_data].to_json,
              group: detect_group(rec[:group])
            )
          end
        end
      end
    end

    def detect_group(name)
      grp = group.find_by(name: name)
      if grp.nil?
        grp = group.new(name: name)
        grp.save
      end
      grp
    end
  end
end
