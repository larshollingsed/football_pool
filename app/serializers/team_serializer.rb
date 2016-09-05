class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :logo_url, :team_record, :location
end
