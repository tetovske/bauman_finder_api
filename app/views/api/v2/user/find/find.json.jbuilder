json.students @data.each do |student|
  subj = JSON.parse(student.subject_data) unless student.subject_data.nil?

  json.first_name student.first_name
  json.second_name student.last_name
  json.mid_name student.mid_name
  json.student_id student.id_stud
  json.group_upon_admission student.group_adm.name unless student.group_adm.nil?
  json.group student.group.name unless student.group.nil?
  json.exam_scores student.exam_scores
  unless subj.nil?
    json.group_rating subj.values[-3]
    json.flow_rating subj.values[-2]
    json.module_points_sum subj.values[-1]
    json.subject_data do 
      json.merge! subj
    end
  end
end