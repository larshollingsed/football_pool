class PickSerializer < ActiveModel::Serializer
  attributes :id, :game_id, :team_id, :user_id, :points, :game, :user, :team
end
