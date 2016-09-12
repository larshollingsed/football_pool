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
    !game.winner.nil?
  end

  def team_belongs_to_game
    game_name = game ? 'The ' + game.name : 'this game'
    team_name = team ? team.name : 'This team'
    errors.add(:team, "#{team_name} is not playing in #{game_name}") unless game && game.teams.include?(team)
    # errors.add(:team, "#{team_name} is not scheduled for a game yet") unless team && team.game
    # errors.add(:team, "#{team.name} is not playing in The #{game.name}") unless game.teams.include?(team)
  end
end
