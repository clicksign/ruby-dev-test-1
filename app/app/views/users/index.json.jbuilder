json.users @users.list.each do |user|
  json.id user.id
  json.email user.email
end