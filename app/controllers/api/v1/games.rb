module API
  module V1
    class Games < Grape::API
      include API::V1::Defaults

      resource :games do
        desc 'Return all games'
        get '', root: :games do
          Game.all
        end

        # create
        desc 'Create a new game'
        params do
          requires :name, type: String
          requires :team_one_id, type: Integer
          requires :team_two_id, type: Integer
          optional :location, type: String
          optional :time, type: DateTime
          optional :spread, type: String
          optional :channel, type: String
        end
        post '' do
          game = Game.new(game_params)
          game.save!
          game
        end

        route_param :game_id, type: Integer do
          desc 'Get a game'
          get '' do
            Game.find(params[:game_id])
          end
          desc 'Update a game'
          params do
            optional :name, type: String
            optional :team_one_id, type: Integer
            optional :team_two_id, type: Integer
            optional :location, type: String
            optional :time, type: DateTime
            optional :spread, type: String
            optional :channel, type: String
            # how will this be cascaded?
            optional :winner_id, type: String
            
            all_or_none_of :team_one_id, :team_two_id
          end
          put '' do
            game = Game.find(params[:game_id])
            game.update!(game_params)
            game
          end
        end
      end

      helpers do
        def game_params
          p = declared(params)
          serialized_params = {}

          allowed_params = [:name, :location, :team_one_id, :team_two_id, :channel, :time, :spread, :winner_id]
          allowed_params.each { |param| serialized_params[param] = p[param] unless p[param].nil? }

          serialized_params
        end
      end

    end
  end
end
