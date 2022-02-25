class BoardSearch

  def initialize(board:, word:)
    self.board = board
    self.word = word.upcase
  end

  def execute
    return false if number_of_rows == 0
    return false if number_of_columns == 0

    @str = ""
    visited = Array.new(number_of_rows) {
      Array.new(number_of_columns, false)
    }

    number_of_rows.times.each do |i|
      number_of_columns.times.each do |j|
        if find_words(visited, i, j)
          return true
        end
      end
    end
    false
   end

  private

  attr_accessor :board, :word

  def number_of_rows
    @number_of_rows ||= board.size
  end

  def number_of_columns
    @number_of_columns ||= board[0].size
  end

  def is_valid_word?(word)
    return false if word.size != @str.size

    for i in 0..word.size - 1
      if @str[i] != word[i] && @str[i] != '*'
        return false
      end
    end
    true
  end

  def find_words(visited, i, j)
    return false if i >= number_of_rows || j >= number_of_columns
    visited[i][j] = true
    @str = @str + board[i][j]

    if is_valid_word?(word)
      return true
    end

    for row in i - 1..i + 1
        for col in j - 1..j + 1
            if (row >= 0 && col >= 0 && col < number_of_columns && row < number_of_rows && !visited[row][col])
                if find_words(visited, row, col)
                  return true
                end
            end
        end
    end

    @str = @str[0..-2] || ""
    visited[i][j] = false
    false
  end
end