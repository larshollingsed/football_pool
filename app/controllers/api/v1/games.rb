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
            game = Game.find(params[:game_id])
            game
          end
          desc 'Update a game'
          params do
            optional :name, type: String
            optional :location, type: String
            optional :time, type: DateTime
            optional :spread, type: String
            optional :channel, type: String
            # how will this be cascaded?
            optional :winner_id, type: String
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

          allowed_params = [:name, :location, :channel, :time, :spread, :winner_id]
          allowed_params.each { |param| serialized_params[param] = p[param] unless p[param].nil? }

          serialized_params
        end
      end

    end
  end
end
