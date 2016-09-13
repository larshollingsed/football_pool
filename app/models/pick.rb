class Pick < ApplicationRecord
  belongs_to :user
  has_one :game, through: :team
  belongs_to :team
  validates :team, presence: true
  validates :game, presence: true
  validate :team_belongs_to_game

  def points_taken
    return game.winner == team ? 0 : points if game_played?
    false
  end

  def game_played?
    game.played?
  end

  def team_belongs_to_game
    team_name = team ? team.name : 'This team'
    game_name = game ? 'The ' + game.name : 'this game'
    errors.add(:team, "#{team_name} is not playing in #{game_name}") unless game && game.teams.include?(team)
  end
end
