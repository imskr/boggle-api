module Presenters
  class Game

    def initialize(game: , additional_fields: false)
      self.game = game
      self.additional_fields = additional_fields
    end

    def to_json
      data = {
        id: game.id,
        token: game.token,
        duration: game.duration,
        board: game.board.api_characters,
      }

      if additional_fields
        data[:time_left] = game.time_left
        data[:points] = game.points
      end

      data
    end

    private

    attr_accessor :game, :additional_fields

  end
end