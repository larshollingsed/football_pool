class Game < ApplicationRecord
  has_many :teams
  has_many :picks
  has_one :winner, class_name: 'Team', primary_key: :winner_id
end
