require 'bcrypt'
class User < ApplicationRecord
  # REQUIRED_POINTS = 91
  REQUIRED_POINTS = 5
  has_many :picks
  validate :all_picks, on: :update
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
    errors.add(:picks, "Points don\'t add up to #{REQUIRED_POINTS}") if points.sum != REQUIRED_POINTS
  end
end
