class Game < ApplicationRecord
  has_many :teams
  has_many :picks

  def played?
    team_one = teams.first
    team_two = teams.second
    return false if team_one.nil? || team_two.nil?

    team_one.played? && team_one.played?
  end

  def winner
    team_one = teams.first
    team_two = teams.second
    return false if team_one.score.nil? || team_two.score.nil?

    team_one.score > team_two.score ? team_one : team_two
  end
end
