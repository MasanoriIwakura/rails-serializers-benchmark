class Api::V1::Users::IndexResource
  include Alba::Resource

  attributes :id, :name, :email
end
