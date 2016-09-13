class PickSerializer < ActiveModel::Serializer
  attributes :id, :points, :game, :user, :team
end
