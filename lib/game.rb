require 'io/console'

class Game
  attr_reader :gameboard, :snake, :food

  def initialize(board_width = 11, board_height = 11)
    @gameboard = Board.new(board_width, board_height)
    @snake = Snake.new(board_width, board_height)
    @food = Food.new(board_width, board_height)
  end

  def print_board
    system("clear")
    puts "Score: #{score} | [Q]uit"

    gameboard.board.each { |row| puts row.join(" ") }
  end

  def score
    snake.size - Snake::DEFAULT_SIZE
  end

  def draw_food_and_snake
    gameboard.create_board
    @gameboard.board[food.x][food.y] = 'o'

    snake.parts.each do |part|
      @gameboard.board[part.x][part.y] = (part == snake.head) ? snake_head_char : 'x'
    end

    print_board
  end

  def snake_head_char
    { left: "<", right: ">", up: "^", down: "*" }.fetch(snake.direction)
  end

  def show_message(text)
    gameboard.create_board
    gameboard.print_text(text)
    print_board
  end

  def show_start_screen
    start = false

    while start == false
      show_message("[S]tart")
      key_code = GetKey.getkey
      sleep(0.5)

      start = true if compare_key(key_code, 'S')
    end
  end

  def check_snake_position
    check_if_snake_met_wall
    check_if_snake_ate_food
    check_if_snake_ate_itself
  end

  def check_if_snake_ate_itself
    raise Snake::AteItselfError if snake.body.include?(snake.head)
  end

  def check_if_snake_met_wall
    new_head_x, new_head_y = snake.head.x, snake.head.y
    max_width, max_height = gameboard.width.pred, gameboard.length.pred

    new_head_x = max_height if snake.head.x < 0
    new_head_x = 0 if snake.head.x > max_height

    new_head_y = 0 if snake.head.y > max_width
    new_head_y = max_width if snake.head.y < 0

    return if [new_head_x, new_head_y] == [snake.head.x, snake.head.y]

    snake.update_head(Point.with(x: new_head_x, y: new_head_y))
  end

  def check_if_snake_ate_food
    if snake.head.x == food.x && snake.head.y == food.y
      snake.increase
      @food = Food.new(gameboard.width, gameboard.length)
    end
  end

  def start
    show_start_screen

    tick
  rescue Snake::AteItselfError
    show_message("Game Over")
  end

  def tick
    in_game = true

    while in_game
      draw_food_and_snake
      sleep(1)

      in_game = execute_action(GetKey.getkey)

      snake.step
      check_snake_position
    end

    show_message("Game Quit")
  end

  def execute_action(key_code)
    return true if key_code.nil?
    return false if compare_key(key_code, 'Q')
    snake.turn(key_code)
  end

  def compare_key(key_code, char)
    return false if key_code.nil?
    key_code.chr.upcase == char.upcase
  end
end
