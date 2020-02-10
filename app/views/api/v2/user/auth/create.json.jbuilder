json.message "user successfully logged in!"
json.data do 
  json.username @user.email.match(/[^@]+/).to_s
  json.token @user.token
end