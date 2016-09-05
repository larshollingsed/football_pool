class Pick < ApplicationRecord
  belongs_to :user
  belongs_to :game
  belongs_to :team

  def game
    Game.find(game_id)
  end

  def team
    Team.find(team_id)
  end

  def user
    byebug
    User.find(user_id)
  end
end
