module API
  module V1
    class Users < Grape::API
      include API::V1::Defaults

      resource :users do
        desc 'Return all users'
        get '', root: :users do
          User.all
        end

        params do
          requires :password, type: String
          requires :password_confirm, type: String
        end
        desc 'Update a user'
        put '', root: :users do
          if params[:password] == params[:password_confirm]
            'match'
          elsif params[:password] == "banana"
            'banana squared'
          else
            'no match'
          end
        end

        desc 'Return a user'
        params do
          requires :id, type: String, desc: 'ID of the user'
        end
        get ':id', root: 'user' do
          User.where(id: permitted_params[:id]).first!
        end
      end
    end
  end
end
