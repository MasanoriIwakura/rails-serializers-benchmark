class JsonApi::ProfileSerializer
  include JSONAPI::Serializer

  attributes :id, :hobby, :details
end
