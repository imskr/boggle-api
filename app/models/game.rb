class Game < ApplicationRecord
  belongs_to :board
  has_many :game_histories

  validates :duration, :points, :board_id, presence: true
  validates :token, uniqueness: true, presence: true
  validates :duration, :points, numericality: {
    only_integer: true, greater_than_or_equal_to: 0
  }

  def valid_token?(token)
    self.token == token
  end

  def time_left
    time_elapsed = (Time.now - Game.first.created_at)

    return 0 if duration < time_elapsed

    (duration - time_elapsed).to_i
  end

  def playable?
    time_left > 0
  end

end
