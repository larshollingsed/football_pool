require 'bcrypt'
class User < ApplicationRecord
  has_many :picks
  validate :all_picks
  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def points
    total = 0
    picks.each do |pick|
      total += pick.points_taken unless pick.points_taken == false
    end
    total
  end

  def points_remaining
    remaining = 0
    picks.each do |pick|
      remaining += pick.points unless pick.game_played?
    end
    remaining
  end

  def all_picks
    points = picks.pluck('points')
    byebug
  end
end
