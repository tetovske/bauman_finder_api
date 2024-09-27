module StudentsHelper
  def nully(field)
    field.nil? ? '-' : field
  end

  # Create view with subject, grades, group
  def exam_data_for_student(student)
    Student.joins(student_semesters: [{ student_session_grades: [:exam_grade, :subject] }, :group, :semester_year])
           .select('students.first_name AS f_name, students.last_name AS l_name, students.mid_name AS m_name,
                    subjects.name AS subj_name, exam_grades.grade AS grade, semester_years.semester_title AS sem')
           .where('lower(students.first_name) LIKE lower(?) AND lower(students.last_name) LIKE lower(?) AND lower(students.mid_name) LIKE lower(?)',
                  student.first_name, student.last_name, student.mid_name).group_by(&:sem)
  end

  def semester_data_for_student(student)
    Student.joins(student_semesters: [{ student_subject_grades: [:grade_type, :subject] }, :group, :semester_year])
           .select('students.first_name AS f_name, students.last_name AS l_name, students.mid_name AS m_name,
                    subjects.name AS subj_name, grade_types.grade_type AS gr_type, student_subject_grades.points AS grade,
                    semester_years.semester_title AS sem')
           .where('lower(students.first_name) LIKE lower(?) AND lower(students.last_name) LIKE lower(?)
                   AND lower(students.mid_name) LIKE lower(?)',
                  student.first_name, student.last_name, student.mid_name).group_by(&:sem)
  end
end
