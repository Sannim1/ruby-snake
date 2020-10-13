require "spec_helper"

RSpec.describe RubySnake::Game do
  subject(:new_game) { described_class.new }

  describe "#new" do
    it "instantiates a new game" do
      expect(new_game.gameboard).to be_kind_of(RubySnake::Board)
      expect(new_game.snake).to be_kind_of(RubySnake::Snake)
      expect(new_game.food).to be_kind_of(RubySnake::Food)
    end
  end

  describe "#check_snake_position" do
    it "runs checks on the snake's current position" do
      expect { new_game.check_snake_position }.to_not raise_error
      expect { new_game.check_snake_position }.to_not change { new_game.snake.body }
    end
  end

  describe "#check_if_snake_ate_itself" do
    it do
      new_game.snake.parts[0] = new_game.snake.parts.last

      expect { new_game.check_if_snake_ate_itself }.to raise_error(RubySnake::Snake::AteItselfError)
      expect { new_game.check_snake_position }.to raise_error(RubySnake::Snake::AteItselfError)
    end
  end

  describe "#check_if_snake_met_wall" do
    let(:snake) { new_game.snake }

    context "when the snake hits the wall" do
      before { snake.parts[0] = RubySnake::Point.with(x: snake.head.x, y: new_game.gameboard.width) }

      it "wraps the head to the other side" do
        expect { new_game.check_if_snake_met_wall }.
          to change { snake.head.y }.from(new_game.gameboard.width).to(0)
      end
    end

    context "when the snake hasn't hit the wall" do
      it "does nothing" do
        expect { new_game.check_if_snake_met_wall }.to_not change { snake.head }
      end
    end
  end

  describe "#check_if_snake_ate_food" do
    let(:snake) { new_game.snake }
    let(:food) { new_game.food }

    context "when the snake's head coincides with the food's coordinates" do
      before { snake.parts[0] = RubySnake::Point.with(x: food.x, y: food.y) }

      it "increases the snake's size" do
        expect { new_game.check_if_snake_ate_food }.
          to change { snake.size }.from(4).to(5)
      end
    end

    context "when there's no food at the position of the snake's head" do
      it "does nothing" do
        expect { new_game.check_if_snake_ate_food }.to_not change { snake.size }
      end
    end
  end

  context "key presses" do
    it "compares pressed key" do
      expect(new_game.compare_key(65, 'a')).to be_truthy
      expect(new_game.compare_key(65, 'A')).to be_truthy
      expect(new_game.compare_key(65, 'Q')).to be_falsey
    end

    it "quits the game on pressing 'Q'" do
      expect(new_game.execute_action('q'.ord)).to eq(false)
    end

    it "turns the snake on pressing 'a'" do
      expect { new_game.execute_action('d'.ord) }.
        to change { new_game.snake.direction }.from(:left).to(:right)

      expect(new_game.execute_action('d'.ord)).to_not be_nil
    end
  end
end
