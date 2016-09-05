module API
  module V1
    class Teams < Grape::API
      include API::V1::Defaults

      resource :teams do
        desc 'Return all teams'
        get '', root: :teams do
          byebug
          Team.all
        end

        # create
        desc 'Create a new user'
        params do
          requires :name, type: String
          optional :location, type: String
          optional :team_record, type: String
          optional :logo_url, type: String
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
            at_least_one_of :name, :location, :team_record, :logo_url
          end
          put '' do
            team = Team.find(params[:team_id])
            team.update!(team_params)
            team
          end
        end

        # resource :teams
      end

      # resource :users do
      #   desc 'Return all users'
      #   get '', root: :users do
      #     User.all
      #   end
      #   # create
      #   desc 'Create a new user'
      #   params do
      #     requires :first_name, type: String
      #     requires :last_name, type: String
      #     requires :email, type: String
      #     requires :password, type: String
      #     requires :password_confirm, type: String
      #   end
      #   post '', root: :users do
      #     p = declared(params)
      #     # add a http code?
      #     return 'Passwords don\'t match' if p.password != p.password_confirm
      #     user = User.new({
      #                       first_name: p.first_name,
      #                       last_name: p.last_name,
      #                       email: p.email,
      #                       password: p.password
      #                     })
      #     user.save!
      #   end
      #
      #   route_param :user_id, type: Integer do
      #     # update
      #     desc 'Update a user'
      #     params do
      #       optional :first_name, type: String
      #       optional :last_name, type: String
      #       optional :email, type: String
      #       optional :new_password, type: String
      #       optional :old_password, type: String
      #
      #       all_or_none_of :old_password, :new_password
      #     end
      #     put '', root: :users do
      #       p = declared(params)
      #       # user_id is filtered with declared
      #       user = User.find(params[:user_id])
      #       if p.new_password
      #         if user.password != p.old_password
      #           status 401
      #           return 'Passwords don\'t match'
      #         else
      #           user.password = p.new_password
      #           user.save!
      #           user
      #         end
      #       else
      #         user.update!(user_params)
      #         user
      #       end
      #     end
      #
      #     desc 'Get a user'
      #     get '' do
      #       User.find(params[:user_id])
      #     end
      #   end
      #   #
      #   # desc 'Return a user'
      #   # params do
      #   #   requires :id, type: String, desc: 'ID of the user'
      #   # end
      #   # get ':id', root: 'user' do
      #   #   User.where(id: permitted_params[:id]).first!
      #   # end
      # end
      #
      # # private
      #
      helpers do
        def team_params
          p = declared(params)
          serialized_params = {}

          allowed_params = [:name, :logo_url, :team_record, :location]
          allowed_params.each { |param| serialized_params[param] = p[param] unless p[param].nil? }

          serialized_params
        end
      end

    end
  end
end
