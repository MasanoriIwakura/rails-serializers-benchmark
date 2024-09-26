class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email
  has_many :profiles, serializer: ProfileSerializer
end
