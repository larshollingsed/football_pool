module API
  module V1
    class Teams < Grape::API
      include API::V1::Defaults

      resource :teams do
        desc 'Return all teams'
        get '', root: :teams do
          Team.all
        end

        # create
        desc 'Create a new team'
        params do
          requires :name, type: String
          optional :location, type: String
          optional :team_record, type: String
          optional :logo_url, type: String
          optional :game_id, type: Integer
        end
        post '', root: :teams do
          team = Team.new(team_params)
          team.save!
          team
        end

        route_param :team_id, type: Integer do
          desc 'Get a team'
          get '' do
            Team.find(params[:team_id])
          end
          desc 'Update a team'
          params do
            optional :name, type: String
            optional :location, type: String
            optional :team_record, type: String
            optional :logo_url, type: String
            optional :game_id, type: Integer
            at_least_one_of :name, :location, :team_record, :logo_url, :game_id
          end
          put '' do
            team = Team.find(params[:team_id])
            team.update!(team_params)
            team
          end
        end

        # resource :teams
      end

      helpers do
        def team_params
          p = declared(params)
          serialized_params = {}

          allowed_params = [:name, :logo_url, :team_record, :location, :game_id]
          allowed_params.each { |param| serialized_params[param] = p[param] unless p[param].nil? }

          serialized_params
        end
      end

    end
  end
end
