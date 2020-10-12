class Board
  attr_reader :length, :width, :board

  # lenght -< number of rows
  # width -> number of columns in each row

  DOT = "."

  def initialize(length, width)
    @length = length
    @width = width
    create_board
  end

  def create_board
    @board = Array.new(length) { Array.new(width, DOT)  }
  end

  def center
    [board.length / 2, board.first.length / 2]
  end

  def middle_row
    board[center.first]
  end

  def print_text(text)
    text_midpoint = text.length / 2
    i = 0
    text.chars.each do |char|
      board[center.first][center.last - text_midpoint + i] = char
      i += 1
    end
  end
end
