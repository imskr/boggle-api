class GameHistory < ApplicationRecord
  belongs_to :game

  validates :points, :word, :game, presence: true
  validates :points, numericality: {
    only_integer: true, greater_than_or_equal_to: 0
  }
  validates :word, uniqueness: {
    scope: :game_id
  }

end
