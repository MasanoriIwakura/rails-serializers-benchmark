class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :email

  association :profiles, blueprint: ProfileBlueprint
end
