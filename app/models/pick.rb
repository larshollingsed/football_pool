class Pick < ApplicationRecord
  belongs_to :user
  belongs_to :game
  belongs_to :team
end
