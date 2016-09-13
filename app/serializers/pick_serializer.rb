class PickSerializer < ActiveModel::Serializer
  attributes :id, :points, :game, :user, :team, :points_taken
end
