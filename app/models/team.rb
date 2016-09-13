class Team < ApplicationRecord
  belongs_to :game
  has_many :picks
  validate :game_should_be_changed?, on: :update

  def game_should_be_changed?
    errors.add(:game, 'Game cannot be changed') if game_id_changed?
  end

  def played?
    !score.nil?
  end
end
