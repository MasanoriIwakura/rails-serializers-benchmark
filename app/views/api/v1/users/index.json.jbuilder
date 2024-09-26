json.serializer @serializer
json.users @users do |user|
  json.id user.id
  json.name user.name
  json.email user.email
  json.profiles user.profiles, :id, :hobby, :details
end
