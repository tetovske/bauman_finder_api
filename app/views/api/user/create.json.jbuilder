json.message "user successfully registered!"
json.data do
  json.username @user.email.match(/[^@]+/).to_s
  json.token @user.token
end