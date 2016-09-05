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
          optional :address, type: String
          optional :address_two, type: String
          optional :city, type: String
          optional :state, type: String
          optional :zip_code, type: Integer
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
          user
        end

        route_param :user_id, type: Integer do
          # update
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

            all_or_none_of :old_password, :new_password
          end
          put '', root: :users do
            p = declared(params)
            user = User.find(params[:user_id])

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

          allowed_params = [:first_name, :last_name, :email, :address, :addres_two, :city, :state, :zip_code]
          allowed_params.each { |param| serialized_params[param] = p[param] unless p[param].nil? }

          serialized_params
        end
      end

    end
  end
end
