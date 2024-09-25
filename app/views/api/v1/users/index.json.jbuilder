json.serializer @serializer
json.users @users, :id, :name, :email, :profiles do |user|
  json.profiles user.profiles, :id, :hobby, :details
end
