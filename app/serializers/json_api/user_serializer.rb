class JsonApi::UserSerializer
  include JSONAPI::Serializer

  attributes :id, :name, :email
  has_many :profiles, serializer: JsonApi::ProfileSerializer
end
