class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :address, :address_two,
             :city, :state, :zip_code, :created_at, :updated_at,
             :picks, :points, :points_remaining
end
