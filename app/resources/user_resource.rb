class UserResource
  include Alba::Resource

  attributes :id, :name, :email

  many :profiles, resource: ProfileResource
end
