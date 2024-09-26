class Api::V1::UsersController < ApplicationController
  def index
    @serializer = params[:serializer] || 'default'
    count = params[:count] || 100
    @users = User.includes(:profiles).limit(count)

    case @serializer
    when 'default'
      render json: render_json
    when 'ams'
      render json: {
        serializer: 'active_model_serializers',
        users: ActiveModelSerializers::SerializableResource.new(@users, each_serializer: UserSerializer)
      }
    when 'blueprinter'
      render json: {
        serializer: 'blueprinter',
        users: UserBlueprint.render_as_hash(@users)
      }
    when 'alba'
      render json: {
        serializer: 'alba',
        users: UserResource.new(@users)
      }
    when 'jbuilder'
      render 'index', formats: :json, handlers: :jbuilder
    when 'jb'
      render 'index', formats: :json, handlers: :jb
    when 'jsonapi'
      # NOTE: ここだけレスポンスの構造が異なる(json-apiに準拠している)
      render json: {
        serializer: 'json-api',
        users: JsonApi::UserSerializer.new(@users).serializable_hash
      }
    else
      raise 'Unknown serializer'
    end
  end

  private

  def render_json
    {
      serializer: @serializer,
      users: @users.map do |user|
        {
          id: user.id,
          name: user.name,
          email: user.email,
          profiles: user.profiles.map do |profile|
            {
              id: profile.id,
              hobby: profile.hobby,
              details: profile.details
            }
          end
        }
      end
    }
  end
end
