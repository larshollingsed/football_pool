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
            requires :user_id, type: Integer
            optional :first_name, type: String
            optional :last_name, type: String
            optional :email, type: String
            optional :new_password, type: String
            optional :old_password, type: String

            all_or_none_of :old_password, :new_password
          end
          put '', root: :users do
            p = declared(params)
            user = User.find(p.user_id)
            if p.new_password
              if user.password != p.old_password
                status 401
                return 'Passwords don\'t match'
              else
                user.password = p.new_password
                user.save!
                user
              end
            else
              user.update!(user_params)
              user
            end
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
      end

      # private

      helpers do
        def user_params
          p = declared(params)
          serialized_params = {}
          serialized_params[:first_name] = p.first_name unless p.first_name.nil?
          serialized_params[:last_name] = p.last_name unless p.last_name.nil?
          serialized_params[:email] = p.email unless p.email.nil?
          serialized_params
        end
      end

    end
  end
end
