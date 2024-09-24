class Api::V1::Users::IndexBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :email
end
