class Api::V1::UsersController < ApplicationController
  def index
    serializer = params[:serializer] || "blueprinter"
    count = params[:count] || 100
    @users = User.includes(:profiles).limit(count)

    case serializer
    when "blueprinter"
      render json: {
        serializer: "blueprinter",
        users: UserBlueprint.render_as_hash(@users)
      }
    when "alba"
      render json: {
        serializer: "alba",
        users: UserResource.new(@users)
      }
    else
      raise "Unknown serializer"
    end
  end
end
