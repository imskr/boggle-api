require "#{Rails.root}/lib/dictionary.rb"

DICTIONARY_FILE_PATH = "#{Rails.root}/config/dictionary.txt".freeze
$dictionary = Dictionary.new(DICTIONARY_FILE_PATH).freeze

DEAULT_BOARD_FILE_PATH = "#{Rails.root}/config/default_board.txt".freeze
DEFAULT_BOARD = File.read(DEAULT_BOARD_FILE_PATH)
                    .strip
                    .split(",")
                    .collect(&:strip)
                    .join(",")
                    .freeze
