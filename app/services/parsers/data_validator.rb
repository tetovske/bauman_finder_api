# frozen_string_literal: true

# Parsers module
module Parsers
  # Fill tables by data coming from parsers
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
          group_id: group.find_by(name: stud[:group]).id
        )
        if record.valid?
          record.save
        else
          upd = student.find_by(id_stud: stud[:id_stud])
          student.update(
            upd.id,
            first_name: stud[:first_name],
            last_name: stud[:last_name],
            mid_name: stud[:mid_name],
            exam_scores: stud[:exam_scores].to_i,
            form_of_study: study_f.find_by(title: stud[:form_of_study]),
            group_id: group.find_by(name: stud[:group]).id
          ) unless upd.nil?
        end
      end
    end

    def update_groups_and_companies(data)
      data.map do |stud|
        company.new(company_name: stud[:company]).save
        group.new(name: stud[:group]).save
      end
    end
  end
end
