module RubySnake
  class Snake
    class AteItselfError < StandardError; end;

    attr_reader :size, :direction, :start_position, :parts

    DEFAULT_SIZE = 4

    KEY_CODE_MAP = {
      W: :up,
      A: :left,
      S: :down,
      D: :right
    }.freeze

    def initialize(max_height, max_width)
      @size = DEFAULT_SIZE
      @direction = :left
      @parts = []
      set_start_position(max_height, max_width)
      create_snake
    end

    def create_snake
      size.times do |iteration|
        @parts << Point.with(x: start_position.x, y: start_position.y + iteration)
      end
    end

    def head
      parts.first
    end

    def body
      parts[1..]
    end

    def set_start_position(max_height, max_width)
      @start_position = Point.with(
        x: Random.rand(0...max_height),
        y: Random.rand(0...max_width)
      )
    end

    def increase
      @size += 1
      @parts << parts.last
    end

    def update_head(new_head)
      @parts[0] = new_head
    end

    def turn(key_code)
      @direction = KEY_CODE_MAP.fetch(key_code.chr.upcase.to_sym, direction)
    end

    def step
      new_head = case direction
      when :left then Point.with(x: head.x, y: head.y.pred)
      when :right then Point.with(x: head.x, y: head.y.next)
      when :up then Point.with(x: head.x.pred, y: head.y)
      when :down then Point.with(x: head.x.next, y: head.y)
      end

      parts.unshift(new_head)
      parts.pop
    end
  end
end
