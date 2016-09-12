class GameSerializer < ActiveModel::Serializer
  attributes :id, :name, :location, :channel, :winner_id, :time, :spread, :teams
end
