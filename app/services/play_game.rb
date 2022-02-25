require_relative "board_search"
class PlayGame

  def initialize(game: , word: )
    self.game = game
    self.word = word.strip
  end

  def execute
    ActiveRecord::Base.transaction do
      game_history = save_history
      allocate_points_to_the_game(game_history)
    end
    valid_word?
  end

  private

  attr_accessor :game, :word

  def allocate_points_to_the_game(game_history)
    return if game_history.nil?

    game.increment!(:points, game_history.points)
  end

  def save_history
    return nil if game_history.present?

    game_history = game.game_histories.build
    game_history.accepted = valid_word?
    game_history.word = word
    game_history.points = calculate_points(word)
    game_history.save!

    game_history
  end

  def valid_word?
    return @valid_word unless @valid_word.nil?

    @valid_word = word_exists_in_dictionary? && word_not_already_choosen? && word_present_on_the_board?
  end

  def word_not_already_choosen?
    game_history.nil?
  end

  def game_history
    @game_history ||= game.game_histories.where(word: word).first
  end

  def word_exists_in_dictionary?
    $dictionary.valid?(word)
  end

  def word_present_on_the_board?
    BoardSearch.new(
      board: game.board.display, word: word
    ).execute
  end

  def calculate_points(word)
    return 0 unless valid_word?

    word.length
  end

end