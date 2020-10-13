require "spec_helper"

describe Snake do
  let(:snake) { Snake.new(4, 4) }

  describe "#new" do
    let(:snake) { Snake.new(4, 4) }

    it "is an array of body parts" do
      expect(snake.parts).to be_kind_of(Array)
      expect(snake.parts.size).to eql(4)
    end

    it "initializes the position of the snake's head" do
      snake_head = snake.parts.first

      expect(snake_head).to_not be_nil

      expect(snake_head.x).to be_kind_of(Integer)
      expect(snake_head.y).to be_kind_of(Integer)
    end

    it "initializes the length of the snake" do
      expect(snake.size).to eq(4)
    end

    it "initializes the snake's direction" do
      expect(snake.direction).to eql(:left)
    end
  end

  describe "#step" do
    it "adds one part to the snake and removes the last part from the snake" do
      old_snake = snake
      new_head = Point.with(x: snake.head.x, y: snake.head.y)
      old_snake.parts.unshift(new_head).pop

      snake.step

      expect(snake.parts).to eq(old_snake.parts)
    end
  end

  describe "#turn" do
    it "changes the snake's direction" do

      expect { snake.turn('w') }.to change(snake, :direction).to(:up)
      expect { snake.turn('a') }.to change(snake, :direction).to(:left)
      expect { snake.turn('s') }.to change(snake, :direction).to(:down)
      expect { snake.turn('d') }.to change(snake, :direction).to(:right)
    end
  end

  describe "#update_head" do
    let!(:old_head) { snake.head }
    let(:new_position) { Point.with(x: old_head.x.next, y: old_head.y) }

    it "sets the position of the snake's head to the supplied position" do
      expect { snake.update_head(new_position) }.
        to change(snake, :head).from(old_head).to(new_position)
    end
  end

  describe "#increase" do
    it "increases the snake length" do
      expect { snake.increase }.to change { snake.size }.from(4).to(5)
      expect { snake.increase }.to change { snake.parts.length }.from(5).to(6)
    end
  end
end
