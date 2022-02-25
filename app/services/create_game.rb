class CreateGame

  def initialize(duration: , input_board: , random: )
    self.duration = duration
    self.input_board = input_board.blank? ? DEFAULT_BOARD : input_board.split(",").collect(&:strip).join(",")
    self.random = random.nil? ? true : random
  end

  def execute
    game = Game.new
    game.duration = duration
    game.token = SecureRandom.hex
    board = initialize_board
    ActiveRecord::Base.transaction do
      board.save!
      game.board_id = board.id
      game.save!
    end

    game
  end

  private

  def initialize_board
    random ? Board.build_with_random_characters : Board.new(characters: input_board)
  end

  attr_accessor :duration, :input_board, :random


end