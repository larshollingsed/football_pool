module API
  module V1
    # Grape Users Router/Controller
    class Users < Grape::API
      include API::V1::Defaults

      resource :users do
        desc 'Return all users'
        get '', root: :users do
          byebug
          User.all
        end

        desc 'Create a new user'
        params do
          requires :first_name, type: String
          requires :last_name, type: String
          requires :email, type: String
          requires :password, type: String
          optional :address, type: String
          optional :address_two, type: String
          optional :city, type: String
          optional :state, type: String
          optional :zip_code, type: Integer
          optional :picks, type: Array
        end
        post '', root: :users do
          p = declared(params)
          user = User.new(user_params)
          if p.picks
            User.transaction do
              p.picks.each do |pick|
                new_pick = Pick.new(pick_params(pick))
                new_pick.user = user
                new_pick.save!
                user.picks << new_pick
              end
              user.save!
            end
          end
          user
        end

        route_param :user_id, type: Integer do
          desc 'Update a user'
          params do
            optional :first_name, type: String
            optional :last_name, type: String
            optional :email, type: String
            optional :new_password, type: String
            optional :old_password, type: String
            optional :address, type: String
            optional :address_two, type: String
            optional :city, type: String
            optional :state, type: String
            optional :zip_code, type: Integer
            optional :picks, type: Array
            # check for array of hashes with game_id, team_id, points?

            all_or_none_of :old_password, :new_password
          end
          put '', root: :users do
            p = declared(params)
            user = User.find(params[:user_id])

            if p.new_password
              if user.password != p.old_password
                status 401
                return "Passwords don't match"
              else
                user.password = p.new_password
                user.save!
                user
              end

            elsif p.picks
              User.transaction do
                p.picks.each do |new_pick|
                  previous_pick = nil
                  game = Team.find(new_pick.team_id).game
                  user.picks.each do |old_pick|
                    if previous_pick.nil?
                      previous_pick = old_pick if old_pick.game == game
                    end
                  end
                  if previous_pick.nil?
                    previous_pick = user.picks.create(pick_params(new_pick))
                    previous_pick.game = game
                  else
                    previous_pick.update(pick_params(new_pick))
                  end
                  previous_pick.save!
                end
                user.update!(user_params)
              end
            end
            user
          end

          desc 'Get a user'
          get '' do
            User.find(params[:user_id])
          end

          resource 'picks' do
            desc "Get a user's picks"
            get '' do
              user = User.find(params[:user_id])
              user.picks
            end
          end
        end
      end

      # private

      helpers do
        def user_params
          p = declared(params)
          serialized_params = {}

          allowed_params = [:first_name, :last_name, :email, :address, :address_two, :city, :state, :zip_code]
          allowed_params.each { |param| serialized_params[param] = p[param] unless p[param].nil? }

          serialized_params
        end

        def pick_params(pick)
          serialized_params = {}
          allowed_params = [:points, :team_id]
          allowed_params.each { |param| serialized_params[param] = pick[param] unless pick[param].nil? }
          serialized_params
        end
      end
    end
  end
end
