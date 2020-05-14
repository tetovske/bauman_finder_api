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
        student = Student.find_or_create_by(id_stud: stud[:id_stud])
        student.update(
          first_name: stud[:first_name],
          last_name: stud[:last_name],
          mid_name: stud[:mid_name],
          id_abitur: stud[:id_abitur],
          exam_scores: stud[:exam_scores].to_i,
          form_of_study: FormOfStudy.find_or_create_by(
              title: convert_form_of_study(stud[:form_of_study])),
          group_adm: Group.find_or_create_by(name: stud[:group_adm])
        )
      end
    end

    def convert_form_of_study(name)
      case name
      when "budget"
        "Бюджет"
      when "paid"
        "Платная"
      when "contract"
        "Целевая"
      end
    end

    def update_groups_and_companies(data)
      data.map do |stud|
        company.new(company_name: stud[:company]).save
        group.new(name: stud[:group]).save
      end
    end

    def update_webvpn_data(data)
      data.each do |data_type, data|
        data.each do |module_id, faculties|
          faculties.each do |faculty_name, departments|
            fac = Faculty.find_or_create_by(name: faculty_name)
            departments.keys.each do |dep|
              unless Department.exists?(name: dep)
                dep_rec = Department.create(name: dep, faculty: fac)
              end
            end
            departments.each do |department_name, groups|
              groups.each do |group_name, students|
                students.each do |student|
                  stud_db = Student.find_or_create_by(
                    first_name: student[:first_name],
                    last_name: student[:last_name],
                    mid_name: student[:mid_name],
                    id_stud: student[:id_stud]
                  )
                  search_sem = data_type.eql?(:modules) ? { semester_title: module_id } : {session_id: module_id}
                  stud_sem = StudentSemester.find_or_create_by(
                    student: Student.find_or_create_by(id_stud: student[:id_stud]),
                    group: Group.find_or_create_by(name: group_name),
                    semester_year: SemesterYear.find_or_create_by(search_sem)
                  )
                  student[:subject_data].each do |grade_type, subjects|
                    subjects.each do |subj_name, grade|
                      subj = Subject.find_or_create_by(name: subj_name)
                      if data_type.eql?(:modules)
                        subj_grade = StudentSubjectGrade.find_or_create_by(
                          student_semester: stud_sem, subject: subj,
                          grade_type: GradeType.find_or_create_by(grade_type: grade_type))
                        subj_grade.update(points: grade.to_i)
                      elsif data_type.eql?(:exams)
                        sess = StudentSessionGrade.find_or_create_by(student_semester: stud_sem, subject: subj)
                        sess.update(exam_grade: ExamGrade.find_or_create_by(grade: grade))
                      end
                    end
                  end
                end
              end
            end
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
