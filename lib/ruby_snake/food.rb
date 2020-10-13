module RubySnake
  class Food
    attr_reader :x, :y

    def initialize(board_width, board_height)
      @x = Random.rand(board_width - 1)
      @y = Random.rand(board_height - 1)
    end

    def coordinates
      [x, y]
    end
  end
end
