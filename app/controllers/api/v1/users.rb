module API
  module V1
    class Users < Grape::API
      include API::V1::Defaults

      resource :users do
        desc 'Return all users'
        get '', root: :users do
          User.all
        end
        # create
        desc 'Create a new user'
        params do
          requires :first_name, type: String
          requires :last_name, type: String
          requires :email, type: String
          requires :password, type: String
          requires :password_confirm, type: String
        end
        post '', root: :users do
          p = declared(params)
          # add a http code?
          return 'Passwords don\'t match' if p.password != p.password_confirm
          user = User.new({
                            first_name: p.first_name,
                            last_name: p.last_name,
                            email: p.email,
                            password: p.password
                          })
          user.save!
        end

        route_param :user_id do
          # update
          desc 'Update a user'
          params do
            optional :first_name, type: String
            optional :last_name, type: String
            optional :email, type: String
            # requires :password, type: String
            requires :password_confirm, type: String
            requires :user_id, type: Integer
          end
          put '', root: :users do
            byebug
            p = declared(params)
            user = User.find(p.user_id)
            # pull password check into a helper module?
            if user.password != p.password_confirm
              status 401
              return 'Passwords don\'t match'
            else
              user.update!(user_params)
            end
            # byebug
          end
        end
        #
        # desc 'Return a user'
        # params do
        #   requires :id, type: String, desc: 'ID of the user'
        # end
        # get ':id', root: 'user' do
        #   User.where(id: permitted_params[:id]).first!
        # end

        private

        def user_params
          # declared(params)[:first_name], declared(params)[:last_name]
          params.permit(:first_name, :last_name, :email, :password)
        end
      end
    end
  end
end
