module API
  module V1
    class Picks < Grape::API
      include API::V1::Defaults

      resource :picks do
        desc 'Return all picks'
        get '' do
          Pick.all
        end

        # create
        desc 'Create a new pick'
        params do
          requires :user_id, type: Integer
          requires :team_id, type: Integer
          requires :points, type: Integer
        end
        post '' do
          pick = Pick.new(pick_params)
          pick.save!
          pick
        end
      end
      # resource :games do
      #   desc 'Return all games'
      #   get '', root: :games do
      #     Game.all
      #   end
      #
        # # create
        # desc 'Create a new game'
        # params do
        #   requires :name, type: String
        #   optional :location, type: String
        #   optional :time, type: DateTime
        #   optional :spread, type: String
        #   optional :channel, type: String
        # end
        # post '' do
        #   game = Game.new(game_params)
        #   game.save!
        #   game
        # end
      #
      #   route_param :game_id, type: Integer do
      #     desc 'Get a game'
      #     get '' do
      #       game = Game.find(params[:game_id])
      #       byebug
      #       game
      #     end
      #     desc 'Update a game'
      #     params do
      #       optional :name, type: String
      #       optional :location, type: String
      #       optional :time, type: DateTime
      #       optional :spread, type: String
      #       optional :channel, type: String
      #       # how will this be cascaded?
      #       optional :winner_id, type: String
      #     end
      #     put '' do
      #       game = Game.find(params[:game_id])
      #       game.update!(game_params)
      #       game
      #     end
      #   end
      # end
      #
      helpers do
        def pick_params
          p = declared(params)
          serialized_params = {}

          allowed_params = [:team_id, :user_id, :points]
          allowed_params.each { |param| serialized_params[param] = p[param] unless p[param].nil? }

          serialized_params
        end
      end

    end
  end
end
