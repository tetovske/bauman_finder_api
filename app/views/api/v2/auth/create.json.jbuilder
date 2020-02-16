json.message "user successfully logged in!"
json.data do 
  json.token @user.jwt_payload
end