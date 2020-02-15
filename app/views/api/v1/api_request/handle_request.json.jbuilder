res = @response

json.status res[:status]
json.cause res[:cause] unless res[:status].eql?(:success)
json.data res[:data].each do |s|
  json.name s.first_name
  json.last_name s.last_name
  json.mid_name s.mid_name
  json.exam_scores s.exam_scores
  json.admitted_group s.group_adm&.name
  json.group s.group&.name
  json.exam_scores s.exam_scores
  json.subjects s.subject_data
end unless res[:data].empty?