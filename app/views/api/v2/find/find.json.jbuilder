res = @response

json.status res[:status]
json.cause res[:cause] unless res[:status].eql?(:success)
json.data res[:data].each do |s|
  json.name s.first_name
  json.last_name s.last_name
  json.mid_name s.mid_name
  json.id_stud s.id_stud
  json.id_abitur s.id_abitur
  json.form_of_study s.form_of_study&.title
  json.exam_scores s.exam_scores
  json.admitted_group s.group_adm&.name
  json.group s.group&.name
  json.company s.company&.company_name
  unless s.subject_data.nil?
    json.subjects_data do
      json.merge! JSON.parse(s.subject_data)
    end
  end
end unless res[:data].nil?