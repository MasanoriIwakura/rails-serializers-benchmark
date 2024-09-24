class Api::V1::UsersController < ApplicationController
  def index
    serializer = params[:serializer] || "blueprinter"
    count = params[:count] || 100
    @users = User.limit(count)

    case serializer
    when "blueprinter"
      render json: {
        serializer: "blueprinter",
        users: Api::V1::Users::IndexBlueprint.render_as_hash(@users)
      }
    when "alba"
      render json: {
        serializer: "alba",
        users: Api::V1::Users::IndexResource.new(@users)
      }
    else
      raise "Unknown serializer"
    end
  end
end
