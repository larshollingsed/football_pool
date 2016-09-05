class GameSerializer < ActiveModel::Serializer
  attributes :id, :team_one_id, :team_two_id, :name, :location, :channel, :winner_id, :time, :spread
end
